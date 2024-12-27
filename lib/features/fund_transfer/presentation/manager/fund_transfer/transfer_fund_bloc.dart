import 'package:bloc/bloc.dart';
import 'package:easy_bank/features/fund_transfer/domain/use_cases/fingerprint_fund_transfer.dart';
import 'package:easy_bank/features/fund_transfer/domain/use_cases/transfer_balance.dart';
import 'package:meta/meta.dart';

part 'transfer_fund_event.dart';
part 'transfer_fund_state.dart';

class TransferFundBloc extends Bloc<TransferFundEvent, TransferFundState> {
  final TransferBalanceUseCase transferBalanceUseCase;
  final FingerprintFundTransferUseCase fingerprintFundTransferUseCase;
  TransferFundBloc(this.transferBalanceUseCase, this.fingerprintFundTransferUseCase) : super(TransferFundInitial()) {
    on<TransferFund>(transferFund);
    on<FingerprintTransferFund>(transferFundFingerprint);
    on<ResetTransferFund>(reset);
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
      emit(TransferFundError('Error: $e'));
    }
  }
  void transferFundFingerprint(FingerprintTransferFund event, emit) async{
    emit(TransferFundLoading());
    try{
      final response =  await fingerprintFundTransferUseCase.execute(event.accountNumber,event.mobileNumber, event.amount);
      if(response){
        emit(TransferFundLoaded());
      }
      else{
        emit(TransferFundError('Error while transferring'));
      }
    }
    catch(e){
      emit(TransferFundError('Error: $e'));
    }
  }

  void reset(event, emit){
    emit(TransferFundInitial());
  }
}
