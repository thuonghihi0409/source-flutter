import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/services/kyc_camera_service.dart';
import '../core/style/app_colors.dart';
import '../core/style/app_text_styles.dart';

class KycCameraWidget extends StatefulWidget {
  final Function(KycCaptureResult) onCaptureComplete;
  final VoidCallback? onCancel;

  const KycCameraWidget({
    super.key,
    required this.onCaptureComplete,
    this.onCancel,
  });

  @override
  State<KycCameraWidget> createState() => _KycCameraWidgetState();
}

class _KycCameraWidgetState extends State<KycCameraWidget> {
  bool _isLoading = false;
  String _statusMessage = 'Preparing camera...';

  @override
  void initState() {
    super.initState();
    _startKycCapture();
  }

  Future<void> _startKycCapture() async {
    setState(() {
      _isLoading = true;
      _statusMessage = 'Starting KYC capture...';
    });

    try {
      final result = await KycCameraService.startKycCapture();

      setState(() {
        _isLoading = false;
        _statusMessage = result.success
            ? 'KYC capture completed successfully!'
            : 'KYC capture failed';
      });

      widget.onCaptureComplete(result);
    } catch (e) {
      setState(() {
        _isLoading = false;
        _statusMessage = 'Error: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'KYC Verification',
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.onBackground,
          ),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.onBackground),
          onPressed: widget.onCancel,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Camera preview placeholder
            Container(
              width: double.infinity,
              height: 300.h,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: AppColors.outline, width: 2),
              ),
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt,
                          size: 64.w,
                          color: AppColors.primary,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'Camera will open automatically',
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: AppColors.onSurface,
                          ),
                        ),
                      ],
                    ),
            ),

            SizedBox(height: 32.h),

            // Status message
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: _isLoading ? AppColors.primary : AppColors.outline,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  if (_isLoading)
                    SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.primary,
                      ),
                    )
                  else
                    Icon(
                      _statusMessage.contains('success')
                          ? Icons.check_circle
                          : Icons.error,
                      color: _statusMessage.contains('success')
                          ? AppColors.success
                          : AppColors.error,
                      size: 20.w,
                    ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      _statusMessage,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // Instructions
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.primaryContainer,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Instructions:',
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    '• Look straight at the camera\n'
                    '• Turn your head to the left\n'
                    '• Turn your head to the right\n'
                    '• The process will complete automatically',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 32.h),

            // Cancel button
            if (widget.onCancel != null)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: _isLoading ? null : widget.onCancel,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.outline),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.onBackground,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
