import 'package:easy_bank/core/services/notification_services.dart';
import 'package:easy_bank/features/profile/data/data_sources/toggle_transaction_data_source.dart';
import 'package:easy_bank/features/profile/data/repository/toggle_transaction_repo_impl.dart';
import 'package:easy_bank/features/profile/domain/repository/toggle_transaction_repository.dart';
import 'package:easy_bank/features/profile/domain/use_cases/toggle_transaction_use_case.dart';
import 'package:easy_bank/shared/data/data_sources/fingerprint_data_source.dart';
import 'package:easy_bank/shared/data/data_sources/local_data_source.dart';
import 'package:easy_bank/features/auth/domain/use_cases/authenticate_with_fingerprint.dart';
import 'package:easy_bank/features/fund_transfer/data/data_sources/fund_transfer_data_sources.dart';
import 'package:easy_bank/features/fund_transfer/data/repositories/fund_transfer_repo_impl.dart';
import 'package:easy_bank/features/fund_transfer/domain/repositories/fund_transfer_repo.dart';
import 'package:easy_bank/features/fund_transfer/domain/use_cases/check_account_number.dart';
import 'package:easy_bank/features/fund_transfer/domain/use_cases/check_mobile_number.dart';
import 'package:easy_bank/features/history/data/data_sources/history_data_sources.dart';
import 'package:easy_bank/features/history/data/repositories/history_repo_impl.dart';
import 'package:easy_bank/features/history/domain/repositories/history_repository.dart';
import 'package:easy_bank/features/history/domain/use_cases/fetch_history_use_case.dart';
import 'package:easy_bank/features/security/change_password/data/data_sources/change_password_data_source.dart';
import 'package:easy_bank/features/security/change_password/data/repositories/change_password_repo_impl.dart';
import 'package:easy_bank/features/security/change_password/domain/repositories/change_password_repository.dart';
import 'package:easy_bank/features/security/change_password/domain/use_cases/change_password_use_case.dart';
import 'package:easy_bank/shared/data/data_sources/profile_data_sources.dart';
import 'package:easy_bank/shared/data/repositories/profile_repo_impl.dart';
import 'package:easy_bank/shared/domain/repositories/profile_repository.dart';
import 'package:easy_bank/shared/domain/use_cases/get_profile_use_case.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';

import '../../features/auth/data/data_sources/auth_data_sources.dart';
import '../../features/auth/data/repositories/auth_repo_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/use_cases/login.dart';
import '../../features/auth/domain/use_cases/save_user_data.dart';
import '../../features/auth/domain/use_cases/send_otp.dart';
import '../../features/auth/domain/use_cases/verify_otp.dart';
import '../../features/fund_transfer/domain/use_cases/fingerprint_fund_transfer.dart';
import '../../features/fund_transfer/domain/use_cases/transfer_balance.dart';
import '../../features/security/change_pin/data/data_sources/change_pin_data_source.dart';
import '../../features/security/change_pin/data/repositories/change_pin_repo_impl.dart';
import '../../features/security/change_pin/domain/repositories/change_pin_repository.dart';
import '../../features/security/change_pin/domain/use_cases/change_pin_use_case.dart';

final authLocator = GetIt.instance;
final profileLocator = GetIt.instance;
final mobileNumberLocator = GetIt.instance;
final accountNumberLocator = GetIt.instance;
final fundTransferLocator = GetIt.instance;
final historyLocator = GetIt.instance;
final changePasswordLocator = GetIt.instance;
final changePinLocator = GetIt.instance;
final packagesLocator = GetIt.instance;
final sharedLocator = GetIt.instance;
final transactionLocator = GetIt.instance;

void setupServiceLocator() {

  //packages
  packagesLocator.registerLazySingleton<LocalAuthentication>(() => LocalAuthentication());
  packagesLocator.registerLazySingleton<FlutterSecureStorage>(() => const FlutterSecureStorage());

  //Auth

  authLocator.registerLazySingleton<AuthRemoteDataSource>(
          () => AuthRemoteDataSourceImpl());
  sharedLocator.registerLazySingleton<FingerprintDataSource>(
          () => FingerprintDataSourceImpl(packagesLocator<LocalAuthentication>()));
  sharedLocator.registerLazySingleton<AuthLocalDataSource>(
          () => AuthLocalDataSourceImpl(packagesLocator<FlutterSecureStorage>()));
  sharedLocator.registerLazySingleton<NotificationServices>(
          () => NotificationServices());

  authLocator.registerLazySingleton<AuthRepository>(
          () => AuthRepositoryImpl(authLocator<AuthRemoteDataSource>(),sharedLocator<AuthLocalDataSource>(),sharedLocator<FingerprintDataSource>()));

  authLocator.registerLazySingleton(() => LoginUseCase(authLocator<AuthRepository>()));
  authLocator.registerLazySingleton(() => SaveUserDataUseCase(authLocator<AuthRepository>(),sharedLocator<NotificationServices>()));
  authLocator.registerLazySingleton(() => SendOtpUseCase(authLocator<AuthRepository>()));
  authLocator.registerLazySingleton(() => VerifyOtpUseCase(authLocator<AuthRepository>()));
  authLocator.registerLazySingleton(() => AuthenticateWthFingerprintUseCase(authLocator<AuthRepository>()));

  //Profile

  profileLocator.registerLazySingleton<ProfileRemoteDatSource>(
          () => ProfileRemoteDataSourceImpl());

  profileLocator.registerLazySingleton<ProfileRepository>(
          () => ProfileRepoImpl(profileLocator<ProfileRemoteDatSource>()));

  profileLocator.registerLazySingleton(() => GetProfileUseCase(profileLocator<ProfileRepository>()));


  //MobileNumber
  mobileNumberLocator.registerLazySingleton<MobileNumberDataSource>(()=>MobileNumberDataSourceImpl());

  mobileNumberLocator.registerLazySingleton<MobileNumberRepository>(()=>MobileNumberRepoImpl(mobileNumberLocator<MobileNumberDataSource>()));

  mobileNumberLocator.registerLazySingleton(()=>CheckMobileNumberUseCase(mobileNumberLocator<MobileNumberRepository>()));

  //accountNumber
  accountNumberLocator.registerLazySingleton<AccountNumberDataSource>(()=>AccountNumberDataSourceImpl());
  accountNumberLocator.registerLazySingleton<AccountNumberRepository>(()=>AccountNumberRepoImpl(accountNumberLocator<AccountNumberDataSource>()));
  accountNumberLocator.registerLazySingleton(()=>CheckAccountNumberUseCase(accountNumberLocator<AccountNumberRepository>()));

  //Fund transfer
  fundTransferLocator.registerLazySingleton<FundTransferDataSource>(()=>FundTransferDataSourceImpl());
  fundTransferLocator.registerLazySingleton<FundTransferRepository>(()=>FundTransferRepoImpl(fundTransferLocator<FundTransferDataSource>(),sharedLocator<AuthLocalDataSource>()));
  fundTransferLocator.registerLazySingleton<FingerprintFundTransferRepository>(()=>FingerprintFundTransferRepoImpl(fundTransferLocator<FundTransferDataSource>(),sharedLocator<AuthLocalDataSource>()));
  fundTransferLocator.registerLazySingleton(()=>FingerprintFundTransferUseCase(fundTransferLocator<FingerprintFundTransferRepository>()));
  fundTransferLocator.registerLazySingleton(()=>TransferBalanceUseCase(fundTransferLocator<FundTransferRepository>()));

  //history
  historyLocator.registerLazySingleton<HistoryDataSource>(()=>HistoryDataSourceImpl());
  historyLocator.registerLazySingleton<HistoryRepository>(()=>HistoryRepoImpl(historyLocator<HistoryDataSource>()));
  historyLocator.registerLazySingleton(()=>FetchHistoryUseCase(historyLocator<HistoryRepository>()));

  //change password
  changePasswordLocator.registerLazySingleton<ChangePasswordDataSource>(()=>ChangePasswordDataSourceImpl());
  changePasswordLocator.registerLazySingleton<ChangePasswordRepository>(()=>ChangePasswordRepositoryImpl(changePasswordLocator<ChangePasswordDataSource>(),sharedLocator<AuthLocalDataSource>()));
  changePasswordLocator.registerLazySingleton(()=>ChangePasswordUseCase(changePasswordLocator<ChangePasswordRepository>()));

  //change pin
  changePinLocator.registerLazySingleton<ChangePinDataSource>(()=>ChangePinDataSourceImpl());
  changePinLocator.registerLazySingleton<ChangePinRepository>(()=>ChangePinRepositoryImpl(changePinLocator<ChangePinDataSource>(),sharedLocator<AuthLocalDataSource>()));
  changePinLocator.registerLazySingleton(()=>ChangePinUseCase(changePinLocator<ChangePinRepository>()));

  //transaction
  transactionLocator.registerLazySingleton<ToggleTransactionDataSource>(()=>ToggleTransactionDataSourceImpl());
  transactionLocator.registerLazySingleton<ToggleTransactionRepository>(()=>ToggleTransactionRepoImpl(transactionLocator<ToggleTransactionDataSource>()));
  transactionLocator.registerLazySingleton(()=>ToggleTransactionUseCase(transactionLocator<ToggleTransactionRepository>()));

}
