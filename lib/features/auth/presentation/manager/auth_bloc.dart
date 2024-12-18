import 'package:bloc/bloc.dart';
import 'package:easy_bank/features/auth/domain/entities/user.dart';
import 'package:easy_bank/features/auth/domain/use_cases/login.dart';
import 'package:easy_bank/features/auth/domain/use_cases/save_user_data.dart';
import 'package:easy_bank/features/auth/domain/use_cases/send_otp.dart';
import 'package:easy_bank/features/auth/domain/use_cases/verify_otp.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final SaveUserDataUseCase saveUserUseCase;
  final SendOtpUseCase sendOtpUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;

  AuthBloc(this.loginUseCase, this.saveUserUseCase, this.sendOtpUseCase, this.verifyOtpUseCase) : super(AuthInitial()) {
    on<SignUpRequested>((event, emit) async {
      emit(SignUpInProgress());
      try {
        await sendOtpUseCase.execute(event.phoneNumber);
        emit(AuthSignUpSuccess(event.phoneNumber));
      } catch (e) {
        emit(AuthFailure("Failed to send OTP: ${e.toString()}"));
      }
    });

    on<VerifyPhoneNumber>((event, emit) async {
      emit(AuthVerificationInProgress());
      try {
        final isVerified = await verifyOtpUseCase.execute(event.otp);
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
        await saveUserUseCase.execute(
          event.name,
          event.phoneNumber,
          event.password,
          event.pin,
        );
        emit(AuthBackendSubmissionSuccess());
      } catch (e) {
        emit(AuthFailure("Failed to save data: ${e.toString()}"));
      }
    });

    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await loginUseCase.execute(event.phoneNumber, event.password);
        print(user.token);
        await Hive.box('SETTINGS').put('token', user.token);
        emit(AuthLoginSuccess(user));
      } catch (e) {
        emit(AuthFailure("Login failed: ${e.toString()}"));
      }
    });
  }
}
