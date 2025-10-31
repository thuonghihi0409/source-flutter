import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceService {
  static Future<String> getDeviceId() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id;
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor ?? 'unknown_ios_device';
    } else if (Platform.isWindows) {
      final WindowsDeviceInfo windowsInfo = await deviceInfo.windowsInfo;
      return windowsInfo.deviceId;
    } else if (Platform.isMacOS) {
      final MacOsDeviceInfo macOsInfo = await deviceInfo.macOsInfo;
      return macOsInfo.systemGUID ?? 'unknown_macos_device';
    } else if (Platform.isLinux) {
      final LinuxDeviceInfo linuxInfo = await deviceInfo.linuxInfo;
      return linuxInfo.machineId ?? 'unknown_linux_device';
    } else {
      return 'unknown_device';
    }
  }
}
