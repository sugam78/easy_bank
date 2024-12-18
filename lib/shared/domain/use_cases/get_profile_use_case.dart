import 'package:easy_bank/shared/domain/entities/profile.dart';
import 'package:easy_bank/shared/domain/repositories/profile_repository.dart';

class GetProfileUseCase{
  final ProfileRepository repository;

  GetProfileUseCase(this.repository);

  Future<Profile> execute(){
    return repository.getProfile();
  }

}