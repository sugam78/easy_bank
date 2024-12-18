import 'package:bloc/bloc.dart';
import 'package:easy_bank/features/fund_transfer/domain/use_cases/check_account_number.dart';
import 'package:meta/meta.dart';

part 'check_account_number_event.dart';
part 'check_account_number_state.dart';

class CheckAccountNumberBloc extends Bloc<CheckAccountNumberEvent, CheckAccountNumberState> {
  final CheckAccountNumberUseCase accountNumberUseCase;
  CheckAccountNumberBloc(this.accountNumberUseCase) : super(CheckAccountNumberInitial()) {
    on<CheckAccountNumberValidity>(checkAccNoValidity);
  }
  void checkAccNoValidity( CheckAccountNumberValidity event, emit) async{
    emit(CheckAccountNumberLoading());
    try{
      final response = await accountNumberUseCase.execute(event.accountNumber);
      if(response){
        emit(CheckAccountNumberLoaded());
      }
      else{
        emit(CheckAccountNumberError('No Account found with this account number'));
      }
    }
    catch(e){
      emit(CheckAccountNumberError('Error: $e'));
    }
  }
}
