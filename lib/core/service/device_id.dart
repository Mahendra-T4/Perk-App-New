import 'dart:developer';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceService {
  static String? _cachedDeviceId;

  static Future<String> getDeviceId() async {
    if (_cachedDeviceId != null) return _cachedDeviceId!;
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      _cachedDeviceId = androidInfo.id.toString();
      return _cachedDeviceId!;
    } catch (e) {
      log('Error getting device ID: $e');
      return 'unknown';
    }
  }
}
