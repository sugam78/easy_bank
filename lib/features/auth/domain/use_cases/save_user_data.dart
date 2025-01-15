import 'package:easy_bank/core/services/notification_services.dart';

import '../repositories/auth_repository.dart';

class SaveUserDataUseCase {
  final AuthRepository repository;
  final NotificationServices notificationServices;
  SaveUserDataUseCase(this.repository, this.notificationServices);

  Future<void> execute(String name,String phoneNumber, String password, String pin) async{
    final fcmToken = await notificationServices.getToken();
    return repository.saveUserData(name, phoneNumber, password, pin,fcmToken);
  }
}
