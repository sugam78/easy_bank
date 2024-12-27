part of 'change_password_bloc.dart';

@immutable
sealed class ChangePasswordEvent {}


final class ChangePassword extends ChangePasswordEvent{
  final String oldPassword,newPassword;

  ChangePassword(this.oldPassword, this.newPassword);
}
final class ResetChangePassword extends ChangePasswordEvent{
}