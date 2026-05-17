import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class HiveService {
  static const String userBoxName = 'userBox';

  static Box<dynamic>? _userBox;

  static Future<void> initHive() async {
    try {
      await Hive.initFlutter();
      _userBox = await Hive.openBox(userBoxName);
    } catch (e) {
      developer.log('Error initializing Hive: $e');
    }
  }

  /// Save a value with key
  static Future<void> setter({
    required String key,
    required dynamic value,
  }) async {
    await _userBox?.put(key, value);
  }

  /// Get a value by key
  static dynamic getter(String key) {
    return _userBox?.get(key);
  }

  /// Delete a value by key
  static Future<void> delete(String key) async {
    await _userBox?.delete(key);
  }

  static Future<void> logout(BuildContext context) async {
    try {
      // Clear all user login data first
      await clearUserData();

      // Close box
      if (_userBox?.isOpen ?? false) {
        await _userBox?.close();
      }

      // Delete box from disk completely
      try {
        await Hive.deleteBoxFromDisk(userBoxName);
      } catch (e) {
        print('Could not delete box from disk: $e');
      }

      // Clear Hive's in-memory cache
      await Hive.close();

      // Reinitialize the box for continued app usage
      _userBox = await Hive.openBox(userBoxName);

      // Navigate to login
      if (context.mounted) {
        // GoRouter.of(context).goNamed(IndoGripLoginPanel.routeName);
      }
    } catch (e) {
      print('Error during logout: $e');
      // Still try to navigate to login even if error occurred
      try {
        if (context.mounted) {
          // GoRouter.of(context).goNamed(IndoGripLoginPanel.routeName);
        }
      } catch (navError) {
        print('Navigation error: $navError');
      }
    }
  }

  /// Clear all data in the box
  static Future<void> clearAll() async {
    try {
      await _userBox?.clear();
    } catch (e) {
      print('Error clearing all data: $e');
    }
  }

  /// Clear all user data (more aggressive than clearAll)
  /// This will completely delete all stored data and can be used
  /// when user wants to clear app data before uninstalling
  static Future<void> clearAllData() async {
    try {
      // First clear all user and login data
      await clearUserData();

      // Close the box
      if (_userBox?.isOpen ?? false) {
        await _userBox?.close();
      }

      // Delete the entire box from disk
      try {
        await Hive.deleteBoxFromDisk(userBoxName);
      } catch (e) {
        print('Could not delete box: $e');
      }

      // Clear Hive's registry
      await Hive.close();

      // Reinitialize Hive and the box for continued app usage
      await initHive();
    } catch (e) {
      print('Error clearing all data: $e');
      rethrow;
    }
  }

  /// Clear specific user data while keeping app settings
  static Future<void> clearUserData() async {
    try {
      // await delete(kUserId);
      // await delete(kUserName);
      // await delete(kEmail);
      // await delete(kPhone);
      // await delete(kRole);
      // await delete(kAuthToken);
      // await delete(kIsLoggedIn);
      // await delete(kLastLogin);

      // // Also delete from HiveKeys
      // await delete(HiveKeys.userIDKey);
      // await delete(HiveKeys.emailKey);
      // await delete(HiveKeys.fNameKey);
      // await delete(HiveKeys.lNameKey);
      // await delete(HiveKeys.mobileKey);
      // await delete(HiveKeys.alternateMobileKey);
      // await delete(HiveKeys.personalEmailKey);
      // await delete(HiveKeys.userImage);
    } catch (e) {
      print('Error clearing user data: $e');
      rethrow;
    }
  }
}
