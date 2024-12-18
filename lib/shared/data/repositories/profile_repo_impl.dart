import 'package:easy_bank/shared/data/data_sources/profile_data_sources.dart';
import 'package:easy_bank/shared/domain/entities/profile.dart';
import 'package:easy_bank/shared/domain/repositories/profile_repository.dart';

class ProfileRepoImpl implements ProfileRepository {
  final ProfileRemoteDatSource profileRemoteDatSource;

  ProfileRepoImpl(this.profileRemoteDatSource);
  @override
  Future<Profile> getProfile() async {
    final profile = await profileRemoteDatSource.getProfile();
    return Profile(
        name: profile.name,
        phone: profile.phone,
        accNumber: profile.accNumber,
        currentBalance: profile.currentBalance,
        accountCreatedDate: profile.accountCreatedDate,
        accountExpiryDate: profile.accountExpiryDate);
  }
}
