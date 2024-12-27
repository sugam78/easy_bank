part of 'change_pin_bloc.dart';

@immutable
sealed class ChangePinEvent {}

final class ChangePin extends ChangePinEvent{
  final String oldPassword, newPin;

  ChangePin(this.oldPassword, this.newPin);
}
final class ResetChangePin extends ChangePinEvent{
}
