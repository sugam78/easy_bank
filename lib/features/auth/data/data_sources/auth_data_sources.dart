import 'package:easy_bank/core/common/services/api_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/constants/api_constants.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<void> sendOTP(String phoneNumber);
  Future<bool> verifyOTP(String otp);
  Future<void> saveUserData(String name,String phoneNumber, String password, String pin,String fcmToken);
  Future<UserModel> login(String phoneNumber, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {

  AuthRemoteDataSourceImpl();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? _verificationId;

  @override
  Future<void> sendOTP(String phoneNumber) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: '+977 $phoneNumber',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          throw Exception("Verification failed: ${e.message}");
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
        timeout: const Duration(seconds: 60),
      );
    } catch (e) {
      throw Exception("Error while sending OTP: $e");
    }
  }

  @override
  Future<bool> verifyOTP(String otp) async {
    try {
      if (_verificationId == null) {
        return false;
      }
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp,
      );

      await _auth.signInWithCredential(credential);
      return true;
    } catch (e) {
      throw Exception("Invalid OTP: $e");
    }
  }


  @override
  Future<void> saveUserData(String name,String phoneNumber, String password, String pin,String fcmToken) async {
    try {
      await apiHandler(ApiConstants.signup, 'POST',body: {
        'name':name,
        'phone':phoneNumber,
        'password':password,
        'pin':pin,
        'fcmToken': fcmToken
      });
    }
    catch (e) {
      throw Exception('$e');
    }
  }

  @override
  Future<UserModel> login(String phoneNumber, String password) async {
    try{
      final response = await apiHandler(ApiConstants.login, 'POST',body: {
        'phone': phoneNumber,
        'password': password
      });
      final user = UserModel.fromJson(response);
      return user;
    }
    catch(e){
      throw Exception('$e');
    }
  }
}
