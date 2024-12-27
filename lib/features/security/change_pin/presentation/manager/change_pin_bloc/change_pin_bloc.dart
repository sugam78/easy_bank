import 'package:bloc/bloc.dart';
import 'package:easy_bank/features/security/change_pin/domain/use_cases/change_pin_use_case.dart';
import 'package:meta/meta.dart';

part 'change_pin_event.dart';
part 'change_pin_state.dart';

class ChangePinBloc extends Bloc<ChangePinEvent, ChangePinState> {
  final ChangePinUseCase changePinUseCase;

  ChangePinBloc(this.changePinUseCase) : super(ChangePinInitial()) {
    on<ChangePin>(changePin);
    on<ResetChangePin>(reset);
  }

  void changePin(ChangePin event, emit) async {
    emit(ChangePinLoading());
    try {
      await changePinUseCase.execute(event.oldPassword, event.newPin);
      emit(ChangePinLoaded());
    }
    catch (e) {
      emit(ChangePinError('$e'));
    }
  }

  void reset(event, emit) {
    emit(ChangePinInitial());
  }
}
