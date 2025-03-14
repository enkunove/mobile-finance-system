import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/client.dart';

import '../../../domain/usecases/client_usecases/registration_usecase.dart';
import '../../../domain/usecases/login.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUsecase registerUsecase;
  final LoginUsecase loginUsecase;

  RegisterBloc({
    required this.registerUsecase,
    required this.loginUsecase,
  }) : super(RegisterInitial()) {
    on<RegisterClient>((event, emit) async {
      emit(RegisterLoading());

      final client = await registerUsecase.register(event.client);

      final loggedInClient = await loginUsecase.login(client.username, client.password);

      if (loggedInClient != null) {
        print(loggedInClient);
        emit(RegisterSuccess(loggedInClient));
      } else {
        emit(RegisterFailure('ошибка'));
      }
        });
  }
}

