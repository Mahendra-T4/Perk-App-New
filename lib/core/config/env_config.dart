import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static String get apiMainEndpointUrl =>
      dotenv.env['APP_API_MAIN_ENDPOINT_URL'] ?? '';

  static Future<void> loadEnv() async {
    try {
      await dotenv.load(fileName: '.env');
    } catch (e) {
      log('Error loading .env file: $e');
    }
  }
}
