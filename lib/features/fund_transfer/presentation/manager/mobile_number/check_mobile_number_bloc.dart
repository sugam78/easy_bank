import 'package:bloc/bloc.dart';
import 'package:easy_bank/features/fund_transfer/domain/use_cases/check_mobile_number.dart';
import 'package:meta/meta.dart';

part 'check_mobile_number_event.dart';
part 'check_mobile_number_state.dart';

class CheckMobileNumberBloc extends Bloc<CheckMobileNumberEvent, CheckMobileNumberState> {
  final CheckMobileNumberUseCase mobileNumberUseCase;
  CheckMobileNumberBloc(this.mobileNumberUseCase) : super(CheckMobileNumberInitial()) {
    on<CheckMobileNumberValidity>(checkMobileNoValidity);
  }
  void checkMobileNoValidity(CheckMobileNumberValidity event, emit) async{
    emit(CheckMobileNumberLoading());
    try{
      final response = await mobileNumberUseCase.execute(event.mobileNumber);
      if(response){
        emit(CheckMobileNumberLoaded());
      }
      else{
        emit(CheckMobileNumberError('No Account found with this mobile number'));
      }
    }
    catch(e){
      emit(CheckMobileNumberError('Error: $e'));
    }
  }
}
