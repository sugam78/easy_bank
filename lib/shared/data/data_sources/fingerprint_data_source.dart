import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:local_auth/local_auth.dart';

abstract class FingerprintDataSource {
  Future<bool> authenticateWithFingerprint({String type = 'Login'});
}

class FingerprintDataSourceImpl implements FingerprintDataSource {
  final LocalAuthentication _localAuth;

  FingerprintDataSourceImpl(this._localAuth);

  @override
  Future<bool> authenticateWithFingerprint({String type = ''}) async {
    try {
      final bool isDeviceSupported = await _localAuth.isDeviceSupported();
      if (!isDeviceSupported) {
        throw Exception('Device does not support biometrics.');
      }

      final bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
      if (!canCheckBiometrics) {
        throw Exception('Fingerprint not supported');
      }
      final value = Hive.box('Biometrics').get('fingerprint$type',defaultValue: false);
      if(!value){
        throw Exception('Fingerprint not enabled. Enable from profile Settings.');
      }
      return await _localAuth.authenticate(
        localizedReason: 'Please authenticate to continue',
        options: const AuthenticationOptions(biometricOnly: true),
      );
    } catch (e) {
      if(e is PlatformException && e.code == 'NotAvailable'){
        throw Exception('No biometrics is set up in this device');
      }
      print('$e');
      throw Exception('$e');
    }
  }
}