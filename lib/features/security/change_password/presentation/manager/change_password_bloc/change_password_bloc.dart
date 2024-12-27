import 'package:bloc/bloc.dart';
import 'package:easy_bank/features/security/change_password/domain/use_cases/change_password_use_case.dart';
import 'package:meta/meta.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final ChangePasswordUseCase changePasswordUseCase;
  ChangePasswordBloc(this.changePasswordUseCase) : super(ChangePasswordInitial()) {
    on<ChangePassword>(changePassword);
    on<ResetChangePassword>(reset);
  }
  void changePassword(ChangePassword event, emit)async {
    emit(ChangePasswordLoading());
    try{
      await changePasswordUseCase.execute(event.oldPassword, event.newPassword);
      emit(ChangePasswordLoaded());
    }
    catch(e){
      emit(ChangePasswordError('$e'));
    }
  }
  void reset( event, emit) {
    emit(ChangePasswordInitial());
  }
}
