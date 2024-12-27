import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class AuthLocalDataSource {
  Future<void> saveCredentials(String? phoneNumber, String? password,String? pin);
  Future<Map<String, String?>> getCredentials();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage _secureStorage;

  AuthLocalDataSourceImpl(this._secureStorage);

  @override
  Future<void> saveCredentials(String? phoneNumber, String? password,String? pin) async {
    if(phoneNumber!=null) {
      await _secureStorage.write(key: 'phoneNumber', value: phoneNumber);
    }
    if(password!=null) {
      await _secureStorage.write(key: 'password', value: password);
    }
    if(pin!=null) {
      await _secureStorage.write(key: 'pin', value: password);
    }
  }

  @override
  Future<Map<String, String?>> getCredentials() async {
    final phoneNumber = await _secureStorage.read(key: 'phoneNumber');
    final password = await _secureStorage.read(key: 'password');
    final pin = await _secureStorage.read(key: 'pin');
    if (phoneNumber == null || password == null|| pin==null) {
      throw Exception('No saved credentials found');
    }
    return {'phoneNumber': phoneNumber, 'password': password,'pin':pin};
  }
}