import 'package:finance_system_controller/features/finance_controller/data/datasources/clients_datasource.dart';
import 'package:finance_system_controller/features/finance_controller/data/repositories/account_repository_impl.dart';
import 'package:finance_system_controller/features/finance_controller/domain/repositories/account_repository.dart';
import 'package:finance_system_controller/features/finance_controller/domain/usecases/client_usecases/registration_usecase.dart';
import 'package:finance_system_controller/features/finance_controller/domain/usecases/manager_usecases/manage_registration_usecases.dart';
import 'package:finance_system_controller/features/finance_controller/presentation/bloc/bank_info_state_management/bank_info_bloc.dart';
import 'package:get_it/get_it.dart';
import '../features/finance_controller/data/datasources/banks_datasource.dart';
import '../features/finance_controller/data/datasources/credits_datasource.dart';
import '../features/finance_controller/data/repositories/bank_repository_impl.dart';
import '../features/finance_controller/domain/entities/bank.dart';
import '../features/finance_controller/domain/entities/system_users/manager.dart';
import '../features/finance_controller/domain/repositories/bank_repository.dart';
import '../features/finance_controller/domain/usecases/admin_usecases/banks_management_usecases.dart';
import '../features/finance_controller/data/datasources/accounts_datasourse.dart';
import '../features/finance_controller/data/repositories/system_users/client_repository_impl.dart';
import '../features/finance_controller/domain/entities/system_users/client.dart';
import '../features/finance_controller/domain/repositories/system_users/client_repository.dart';
import '../features/finance_controller/domain/usecases/client_usecases/account_management_usecases.dart';
import '../features/finance_controller/domain/usecases/login.dart';
import '../features/finance_controller/presentation/bloc/login_state_management/login_bloc.dart';
import '../features/finance_controller/presentation/bloc/registration_state_management/register_bloc.dart';

class InjectionContainer {
  static final GetIt sl = GetIt.instance;

  static Future<void> init() async {
    sl.registerLazySingleton<ClientsDatasource>(() => ClientsDatasource());
    sl.registerLazySingleton<AccountsDatasource>(() => AccountsDatasource());
    sl.registerLazySingleton<BanksDatasource>(() => BanksDatasource());
    sl.registerLazySingleton<CreditsDatasource>(() => CreditsDatasource());

    sl.registerLazySingleton<ClientRepository>(
            () => ClientRepositoryImpl(clientsDatasource: sl(), accountsDatasource: sl()));
    sl.registerLazySingleton<AccountRepository>(
            () => AccountRepositoryImpl(accountsDatasource: sl(), clientsDatasource: sl()));
    sl.registerLazySingleton<BankRepository>(() => BankRepositoryImpl(banksDatasource: sl()));

    sl.registerFactory<Client>(() => Client(
      '', '',
      fullName: '',
      passportSeriesAndNumber: '',
      idNumber: 0,
      phone: '',
      email: '',
      isApproved: false
    ));

    sl.registerFactory<Manager>(() => Manager('manager', 'manager'));
    sl.registerFactory<RegisterUsecase>(() => RegisterUsecase(sl()));
    sl.registerLazySingleton<LoginUsecase>(() => LoginUsecase(sl()));
    sl.registerLazySingleton<AccountManagementUsecases>(() => AccountManagementUsecases(sl(), sl()));
    sl.registerLazySingleton<BankManagementUsecases>(() => BankManagementUsecases(sl()));
    sl.registerLazySingleton<ManageRegistrationUsecases>(() => ManageRegistrationUsecases(sl()));
    sl.registerFactory<RegisterBloc>(() => RegisterBloc(
      registerUsecase: sl<RegisterUsecase>(),
      loginUsecase: sl<LoginUsecase>(),
    ));
    sl.registerFactory<LoginBloc>(() => LoginBloc(sl()));
    sl.registerFactoryParam<BankInfoBloc, Client, Bank>(
            (client, bank) => BankInfoBloc(sl(), client, bank));
  }
}
