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
      await InjectionContainer.sl<ClientsDatasource>().insertClient(ClientModel(
        username: "sp1",
        password: "sp1",
        fullName: "Specialist 1",
        passportSeriesAndNumber: "",
        phone: "",
        email: "",
        isApproved: true,
        role: "ExternalSpecialist",
      ));

      await InjectionContainer.sl<ClientsDatasource>().insertClient(ClientModel(
        username: "sp2",
        password: "sp2",
        fullName: "Specialist 2",
        passportSeriesAndNumber: "",
        phone: "",
        email: "",
        isApproved: true,
        role: "ExternalSpecialist",
      ));

      await InjectionContainer.sl<ClientsDatasource>().insertClient(ClientModel(
        username: "sp3",
        password: "sp3",
        fullName: "Specialist 3",
        passportSeriesAndNumber: "",
        phone: "",
        email: "",
        isApproved: true,
        role: "ExternalSpecialist",
      ));

      await InjectionContainer.sl<ClientsDatasource>().insertClient(ClientModel(
        username: "sp4",
        password: "sp4",
        fullName: "Specialist 4",
        passportSeriesAndNumber: "",
        phone: "",
        email: "",
        isApproved: true,
        role: "ExternalSpecialist",
      ));

      await InjectionContainer.sl<ClientsDatasource>().insertClient(ClientModel(
        username: "sp5",
        password: "sp5",
        fullName: "Specialist 5",
        passportSeriesAndNumber: "",
        phone: "",
        email: "",
        isApproved: true,
        role: "ExternalSpecialist",
      ));

      await InjectionContainer.sl<ClientsDatasource>().insertClient(ClientModel(
        username: "sp6",
        password: "sp6",
        fullName: "Specialist 6",
        passportSeriesAndNumber: "",
        phone: "",
        email: "",
        isApproved: true,
        role: "ExternalSpecialist",
      ));

      await InjectionContainer.sl<ClientsDatasource>().insertClient(ClientModel(
        username: "sp7",
        password: "sp7",
        fullName: "Specialist 7",
        passportSeriesAndNumber: "",
        phone: "",
        email: "",
        isApproved: true,
        role: "ExternalSpecialist",
      ));

      await InjectionContainer.sl<ClientsDatasource>().insertClient(ClientModel(
        username: "sp8",
        password: "sp8",
        fullName: "Specialist 8",
        passportSeriesAndNumber: "",
        phone: "",
        email: "",
        isApproved: true,
        role: "ExternalSpecialist",
      ));

      await InjectionContainer.sl<ClientsDatasource>().insertClient(ClientModel(
        username: "sp9",
        password: "sp9",
        fullName: "Specialist 9",
        passportSeriesAndNumber: "",
        phone: "",
        email: "",
        isApproved: true,
        role: "ExternalSpecialist",
      ));

      await InjectionContainer.sl<ClientsDatasource>().insertClient(ClientModel(
        username: "sp10",
        password: "sp10",
        fullName: "Specialist 10",
        passportSeriesAndNumber: "",
        phone: "",
        email: "",
        isApproved: true,
        role: "ExternalSpecialist",
      ));
    }
    print( await InjectionContainer.sl<ClientsDatasource>().getClients());
    return Future.value();
  }
}
