import 'package:finance_system_controller/features/finance_controller/data/datasources/clients_datasource.dart';
import 'package:finance_system_controller/features/finance_controller/data/models/system_users/client_model.dart';

import '../../../../../core/injection_container.dart';
import '../../../data/datasources/banks_datasource.dart';

class InitializerUsecase {
  Future<void> initializeApplication() async {
    final t1 = await InjectionContainer.sl<BanksDatasource>().getBanks();
    if (t1 == [] || t1.isEmpty) {
      await InjectionContainer.sl<BanksDatasource>().initBanks();
    }
    final t2 = await InjectionContainer.sl<ClientsDatasource>().getClients();
    if (t2 == [] || t2.isEmpty) {
      await InjectionContainer.sl<ClientsDatasource>().insertClient(ClientModel(
          username: "manager",
          password: "manager",
          fullName: "Manager",
          passportSeriesAndNumber: "",
          phone: "",
          email: '',
          isApproved: true,
          role: "Manager"));
      await InjectionContainer.sl<ClientsDatasource>().insertClient(ClientModel(
          username: "operator",
          password: "operator",
          fullName: "Operator",
          passportSeriesAndNumber: "",
          phone: "",
          email: '',
          isApproved: true,
          role: "Operator"));
      await InjectionContainer.sl<ClientsDatasource>().insertClient(ClientModel(
          username: "admin",
          password: "admin",
          fullName: "Administrator",
          passportSeriesAndNumber: "",
          phone: "",
          email: '',
          isApproved: true,
          role: "Admin"));
    }
    return Future.value();
  }
}
