import 'package:flutter/material.dart';
import 'package:perk_app/app.dart';
import 'package:perk_app/core/config/env_config.dart';
import 'package:perk_app/core/service/device_id.dart';

//main file

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Don't await here - fetch async after app starts
  // DeviceService.getDeviceId(); // Remove await
  runApp(const App());
}
