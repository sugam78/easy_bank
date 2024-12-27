part of 'change_pin_bloc.dart';

@immutable
sealed class ChangePinState {}

final class ChangePinInitial extends ChangePinState {}
final class ChangePinLoading extends ChangePinState {}
final class ChangePinLoaded extends ChangePinState {}
final class ChangePinError extends ChangePinState {
  final String message;

  ChangePinError(this.message);
}
