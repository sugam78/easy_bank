import 'package:easy_bank/features/fund_transfer/data/data_sources/fund_transfer_data_sources.dart';
import 'package:easy_bank/features/fund_transfer/data/repositories/fund_transfer_repo_impl.dart';
import 'package:easy_bank/features/fund_transfer/domain/repositories/fund_transfer_repo.dart';
import 'package:easy_bank/features/fund_transfer/domain/use_cases/check_account_number.dart';
import 'package:easy_bank/features/fund_transfer/domain/use_cases/check_mobile_number.dart';
import 'package:easy_bank/shared/data/data_sources/profile_data_sources.dart';
import 'package:easy_bank/shared/data/repositories/profile_repo_impl.dart';
import 'package:easy_bank/shared/domain/repositories/profile_repository.dart';
import 'package:easy_bank/shared/domain/use_cases/get_profile_use_case.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/data_sources/auth_data_sources.dart';
import '../../features/auth/data/repositories/auth_repo_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/use_cases/login.dart';
import '../../features/auth/domain/use_cases/save_user_data.dart';
import '../../features/auth/domain/use_cases/send_otp.dart';
import '../../features/auth/domain/use_cases/verify_otp.dart';
import '../../features/fund_transfer/domain/use_cases/transfer_balance.dart';

final authLocator = GetIt.instance;
final profileLocator = GetIt.instance;
final mobileNumberLocator = GetIt.instance;
final accountNumberLocator = GetIt.instance;
final fundTransferLocator = GetIt.instance;

void setupServiceLocator() {

  //Auth

  authLocator.registerLazySingleton<AuthRemoteDataSource>(
          () => AuthRemoteDataSourceImpl());

  authLocator.registerLazySingleton<AuthRepository>(
          () => AuthRepositoryImpl(authLocator<AuthRemoteDataSource>()));

  authLocator.registerLazySingleton(() => LoginUseCase(authLocator<AuthRepository>()));
  authLocator.registerLazySingleton(() => SaveUserDataUseCase(authLocator<AuthRepository>()));
  authLocator.registerLazySingleton(() => SendOtpUseCase(authLocator<AuthRepository>()));
  authLocator.registerLazySingleton(() => VerifyOtpUseCase(authLocator<AuthRepository>()));

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
  fundTransferLocator.registerLazySingleton<FundTransferRepository>(()=>FundTransferRepoImpl(fundTransferLocator<FundTransferDataSource>()));
  fundTransferLocator.registerLazySingleton(()=>TransferBalanceUseCase(fundTransferLocator<FundTransferRepository>()));

}
