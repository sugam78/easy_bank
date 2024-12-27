import 'package:bloc/bloc.dart';
import 'package:easy_bank/features/profile/domain/use_cases/toggle_transaction_use_case.dart';
import 'package:meta/meta.dart';

part 'toggle_transaction_event.dart';
part 'toggle_transaction_state.dart';



class ToggleTransactionBloc extends Bloc<ToggleTransactionEvent, ToggleTransactionState> {
  final ToggleTransactionUseCase toggleTransactionUseCase;

  ToggleTransactionBloc(this.toggleTransactionUseCase) : super(ToggleTransactionInitial()) {
    on<ToggleTransaction>(_onToggleTransaction);
    on<ResetToggleTransaction>(reset);
  }

  void _onToggleTransaction(ToggleTransaction event, Emitter<ToggleTransactionState> emit) async {
    emit(ToggleTransactionLoading());
    try {
      final val = await toggleTransactionUseCase.execute();
      emit(ToggleTransactionLoaded(val));
    } catch (e) {
      print('$e');
      emit(ToggleTransactionError('$e'));
    }
  }
  void reset( event, emit) async {
    emit(ToggleTransactionInitial());

  }
}
