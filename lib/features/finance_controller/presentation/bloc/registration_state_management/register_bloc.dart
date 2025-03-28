import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/enterprise.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/client.dart';
import 'package:finance_system_controller/features/finance_controller/domain/usecases/externalspecialist_usecases/enterprises_usecases.dart';

import '../../../domain/usecases/registration_usecase.dart';
import '../../../domain/usecases/login_usecases.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUsecase registerUsecase;
  final LoginUsecase loginUsecase;
  final EnterprisesUsecases bankManagementUsecases;

  RegisterBloc({
    required this.registerUsecase,
    required this.loginUsecase,
    required this.bankManagementUsecases
  }) : super(RegisterInitial()) {
    on<RegisterClient>((event, emit) async {
      emit(RegisterLoading());
      final client = await registerUsecase.register(event.client);
      final loggedInClient =
          await loginUsecase.login(client.username, client.password);

      if (loggedInClient != null) {
        print(loggedInClient);
        emit(RegisterSuccess(loggedInClient));
      } else {
        emit(RegisterFailure('ошибка'));
      }
    });

    on<RegisterEnterprise>((event, emit) async {
      await bankManagementUsecases.createEnterprise(event.enterprise);
    });
  }
}
