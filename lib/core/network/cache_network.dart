import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/strings.dart';
import '../services/logging_service.dart';
import '../services/user_session_service.dart';

class CacheManager {
  static late final FlutterSecureStorage _secureStorage;

  static Future<void> cacheInitialization() async {
    try {
      _secureStorage = const FlutterSecureStorage(
        aOptions: AndroidOptions(
          encryptedSharedPreferences: true,
        ),
        iOptions: IOSOptions(
          accessibility: KeychainAccessibility.first_unlock,
        ),
      );
      UserSessionService.kUserToken = await CacheManager.getString(key: AppStrings.kCachedToken);
    } catch (e, stackTrace) {
      LoggingService.showMsg("Cache init failed: $e\nStackTrace: $stackTrace");
    }
  }

  /// Insert String
  static Future<bool> insertString({required String key, required String value}) async {
    try {
      await _secureStorage.write(key: key, value: value);
      return true;
    } catch (e) {
      LoggingService.showMsg("Ex: $e");
      return false;
    }
  }

  /// Insert Int (stored as String)
  static Future<bool> setInt({required String key, required int value}) async {
    try {
      await _secureStorage.write(key: key, value: value.toString());
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Insert Bool (stored as String "true"/"false")
  static Future<bool> insertBool({required String key, required bool value}) async {
    try {
      await _secureStorage.write(key: key, value: value.toString());
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Get Bool
  static Future<bool?> getBool({required String key}) async {
    try {
      final value = await _secureStorage.read(key: key);
      return value == "NULL" ? null : value?.toLowerCase() == 'true';
    } catch (_) {
      return null;
    }
  }

  /// Get Int
  static Future<int?> getInt({required String key}) async {
    try {
      final value = await _secureStorage.read(key: key);
      return value == "NULL" ? null : value != null ? int.tryParse(value) : null;
    } catch (_) {
      return null;
    }
  }

  /// Get String
  static Future<String?> getString({required String key}) async {
    try {
      return await _secureStorage.read(key: key);
    } catch (e) {
      LoggingService.showMsg("Ex: $e");
      return null;
    }
  }

  /// Remove Item
  static Future<bool> removeItem({required String key}) async {
    try {
      await _secureStorage.delete(key: key);
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Clear All Secure Data
  static Future<bool> clearCache() async {
    try {
      await _secureStorage.deleteAll();
      return true;
    } catch (_) {
      return false;
    }
  }
}
