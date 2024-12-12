import 'package:bloc/bloc.dart';
import 'package:easy_bank/features/auth/data/data_sources/auth_data_sources.dart';
import 'package:easy_bank/features/auth/data/models/user_model.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    final authRepository = AuthRemoteDataSourceImpl();
    on<SignUpRequested>((event, emit) async {
      emit(SignUpInProgress());
      try {
        await authRepository.sendOTP(event.phoneNumber);
        emit(AuthSignUpSuccess(event.phoneNumber));
      } catch (e) {
        emit(AuthFailure("Failed to send OTP: ${e.toString()}"));
      }
    });

    on<VerifyPhoneNumber>((event, emit) async {
      emit(AuthVerificationInProgress());
      try {
        final isVerified = await authRepository.verifyOTP(
          event.otp,
        );
        if (isVerified) {
          emit(AuthVerificationSuccess());
        } else {
          emit(AuthFailure("Invalid OTP"));
        }
      } catch (e) {
        emit(AuthFailure("Verification failed: ${e.toString()}"));
      }
    });

    on<SendUserDataToBackend>((event, emit) async {
      emit(AuthLoading());
      try {
        print(event.name);
        print(event.phoneNumber);
        print(event.password);
        print(event.pin);
        await authRepository.saveUserData(
          event.name,
          event.phoneNumber,
          event.password,
          event.pin,
        );print('Hehehhehe \n' * 10);
        emit(AuthBackendSubmissionSuccess());
      } catch (e) {
        print(e.toString());
        emit(AuthFailure("Failed to save data: ${e.toString()}"));
      }
    });

    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.login(
          event.phoneNumber,
          event.password,
        ).then((value){
          Hive.box('SETTINGS').put('token', value.token);
          emit(AuthLoginSuccess(value));
        });


      } catch (e) {
        print('Failure: $e');
        emit(AuthFailure("Login failed: ${e.toString()}"));
      }
    });
  }
}
