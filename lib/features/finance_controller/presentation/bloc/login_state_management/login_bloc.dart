import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/system_users/client.dart';
import '../../../domain/usecases/login.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase loginUsecase;

  LoginBloc(this.loginUsecase) : super(LoginInitial()) {
    on<LoginClient>((event, emit) async {
      emit(LoginLoading());

      final loggedInClient =
          await loginUsecase.login(event.username, event.password);

      if (loggedInClient != null) {
        print(loggedInClient);
        emit(LoginSuccess(loggedInClient));
      } else {
        emit(LoginFailure('Ошибка при логине'));
      }
    });
  }
}
