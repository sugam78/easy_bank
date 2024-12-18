import 'package:bloc/bloc.dart';
import 'package:easy_bank/features/fund_transfer/domain/use_cases/transfer_balance.dart';
import 'package:meta/meta.dart';

part 'transfer_fund_event.dart';
part 'transfer_fund_state.dart';

class TransferFundBloc extends Bloc<TransferFundEvent, TransferFundState> {
  final TransferBalanceUseCase transferBalanceUseCase;
  TransferFundBloc(this.transferBalanceUseCase) : super(TransferFundInitial()) {
    on<TransferFund>(transferFund);
  }
  void transferFund(TransferFund event, emit) async{
    emit(TransferFundLoading());
    try{
      final response =  await transferBalanceUseCase.execute(event.accountNumber,event.mobileNumber,event.pin, event.amount);
      if(response){
        emit(TransferFundLoaded());
      }
      else{
        emit(TransferFundError('Error while transferring'));
      }
    }
    catch(e){
      TransferFundError('Error: $e');
    }
  }
}
