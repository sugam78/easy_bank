import 'package:flutter_bloc/flutter_bloc.dart';

class CooldownCubit extends Cubit<bool> {
  CooldownCubit() : super(false);

  void startCooldown() {
    emit(true);
    Future.delayed(const Duration(seconds: 3), () {
      emit(false);
    });
  }
}
