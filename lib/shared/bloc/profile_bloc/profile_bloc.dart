import 'package:bloc/bloc.dart';
import 'package:easy_bank/shared/domain/entities/profile.dart';
import 'package:easy_bank/shared/domain/use_cases/get_profile_use_case.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  ProfileBloc(this.getProfileUseCase) : super(ProfileInitial()) {
    on<GetProfile>(_getProfile);
    on<ResetProfile>(reset);
  }
  void _getProfile(event, emit)async {
    emit(ProfileLoading());
    try{
      final profile = await getProfileUseCase.execute();
      emit(ProfileLoaded(profile));
    }
    catch(e){
      emit(ProfileError('Error: $e'));
    }
  }
  void reset(event,emit){
    emit(ProfileInitial());
  }
}
