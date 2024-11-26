import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bitirme_projesi/data/entity/userManager.dart';

class LoginPagecubit extends Cubit<bool> {
  LoginPagecubit() : super(false);

  final UserManager userManager = UserManager();

  Future<void> loginUser(String userName, String password) async {
    const defaultUserName = "Utku";
    const defaultPassword = "111111";

    if (userName == defaultUserName && password == defaultPassword) {
      await userManager.saveUserName(userName);
      await userManager.savePassword(password);
      emit(true);
    } else {
      emit(false);
    }
  }
}
