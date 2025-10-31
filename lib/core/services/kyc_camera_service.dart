import 'dart:async';

import 'package:flutter/services.dart';

class KycCaptureResult {
  final bool success;
  final List<String> images;
  final String? video;
  final bool isPending;
  final String? message;

  const KycCaptureResult({
    required this.success,
    required this.images,
    this.video,
    this.isPending = false,
    this.message,
  });
}

class KycCameraService {
  static const MethodChannel _channel = MethodChannel(
    'ai.dnpay.app/kyc_camera',
  );
  static const MethodChannel _resultChannel = MethodChannel(
    'ai.dnpay.app/kyc_camera_result',
  );

  static Future<KycCaptureResult> startKycCapture() async {
    try {
      print('🎬 Starting native KYC capture...');

      // ALWAYS set up result listener BEFORE starting activity
      // This ensures callback is ready when native sends result
      _resultChannelMethodHandler = _handleMethodCall;
      _resultChannel.setMethodCallHandler(_handleMethodCall);
      print('✅ Result channel handler set');

      // Start the native camera activity (this is asynchronous - activity starts)
      await _channel.invokeMethod('startKycCamera');

      print('✅ Native camera started, returning pending result...');

      // Return a pending result - the actual result will come through the result channel
      // Return a pending result so the Future completes and UI doesn't freeze
      return const KycCaptureResult(
        success: false,
        images: [],
        isPending: true,
        message: 'Camera started, waiting for result...',
      );
    } catch (e) {
      print('❌ Error starting camera: $e');
      return KycCaptureResult(
        success: false,
        images: [],
        message: 'Error starting camera: ${e.toString()}',
      );
    }
  }

  static Future<Map<String, dynamic>> getCameraStatus() async {
    try {
      final result = await _channel.invokeMethod('getCameraStatus');
      return Map<String, dynamic>.from(result);
    } catch (e) {
      return {
        'isInitialized': false,
        'hasActivity': false,
        'hasContext': false,
        'error': e.toString(),
      };
    }
  }

  static Future<bool> cleanupOldFiles({int maxAgeHours = 24}) async {
    try {
      await _channel.invokeMethod('cleanupOldFiles', {
        'maxAgeHours': maxAgeHours,
      });
      return true;
    } catch (e) {
      print('Error cleaning up old files: $e');
      return false;
    }
  }

  static Future<Map<String, dynamic>> getStorageInfo() async {
    try {
      final result = await _channel.invokeMethod('getStorageInfo');
      return Map<String, dynamic>.from(result);
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  static Future<void> _handleMethodCall(MethodCall call) async {
    print('📨 Received method call: ${call.method}');

    switch (call.method) {
      case 'onKycCaptureCompleted':
        final result = call.arguments as Map<dynamic, dynamic>;
        final videoPath = result['videoPath'] as String?;
        final success = result['success'] as bool? ?? false;
        final message = result['message'] as String?;

        // Get image paths from the result
        final imagesList = result['images'] as List<dynamic>?;
        final facePaths =
            imagesList?.map((e) => e.toString()).toList() ?? <String>[];

        // Ensure deterministic order: front -> left -> right
        int rank(String path) {
          final p = path.toLowerCase();
          if (p.contains('_front_')) return 0;
          if (p.contains('_left_')) return 1;
          if (p.contains('_right_')) return 2;
          return 3;
        }
        final sortedFacePaths = [...facePaths]
          ..sort((a, b) {
            final ra = rank(a);
            final rb = rank(b);
            if (ra != rb) return ra - rb;
            return a.compareTo(b); // stable fallback
          });

        print(
          '📸 Received KYC result: success=$success, videoPath=$videoPath, imageCount=${facePaths.length}',
        );

        if (facePaths.isNotEmpty) {
          print('📷 Images: ${facePaths.join(", ")}');
        }

        // Notify listeners about the completed capture
        if (_onCaptureCompleted != null) {
          print('✅ Calling onCaptureCompleted callback');

          // Schedule callback on next event loop to ensure UI updates properly
          scheduleMicrotask(() {
            _onCaptureCompleted?.call(
              KycCaptureResult(
                success: success,
                images: sortedFacePaths,
                video: videoPath,
                isPending: false,
                message: message,
              ),
            );
          });
        } else {
          print('⚠️ No callback set for capture completed');
        }
        break;
      default:
        print('Unknown method call: ${call.method}');
    }
  }

  // Keep reference to handler to prevent GC
  static Future<dynamic> Function(MethodCall)? _resultChannelMethodHandler;

  // Callback for when capture is completed
  static Function(KycCaptureResult)? _onCaptureCompleted;

  static void setOnCaptureCompleted(Function(KycCaptureResult) callback) {
    print('📞 Setting capture callback');
    _onCaptureCompleted = callback;
    print('📞 Capture callback set (is null: ${_onCaptureCompleted == null})');

    // ALWAYS set up result channel handler when callback is set
    if (_resultChannelMethodHandler == null) {
      _resultChannelMethodHandler = _handleMethodCall;
      _resultChannel.setMethodCallHandler(_handleMethodCall);
      print('✅ Result channel handler initialized');
    }
  }

  static void clearOnCaptureCompleted() {
    print('🗑️ Clearing capture callback');
    _onCaptureCompleted = null;
  }
}
