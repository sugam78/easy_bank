part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

final class GetProfile extends ProfileEvent{}
final class ResetProfile extends ProfileEvent{}
