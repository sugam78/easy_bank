import 'package:get_it/get_it.dart';

import '../../features/auth/data/data_sources/auth_data_sources.dart';
import '../../features/auth/data/repositories/auth_repo_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/use_cases/login.dart';
import '../../features/auth/domain/use_cases/save_user_data.dart';
import '../../features/auth/domain/use_cases/send_otp.dart';
import '../../features/auth/domain/use_cases/verify_otp.dart';

final authLocator = GetIt.instance;

void setupServiceLocator() {

  //Auth

  // Data sources
  authLocator.registerLazySingleton<AuthRemoteDataSource>(
          () => AuthRemoteDataSourceImpl());

  // Repositories
  authLocator.registerLazySingleton<AuthRepository>(
          () => AuthRepositoryImpl(authLocator<AuthRemoteDataSource>()));

  // Use cases
  authLocator.registerLazySingleton(() => LoginUseCase(authLocator<AuthRepository>()));
  authLocator.registerLazySingleton(() => SaveUserDataUseCase(authLocator<AuthRepository>()));
  authLocator.registerLazySingleton(() => SendOtpUseCase(authLocator<AuthRepository>()));
  authLocator.registerLazySingleton(() => VerifyOtpUseCase(authLocator<AuthRepository>()));
}
