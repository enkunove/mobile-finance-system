import 'package:finance_system_controller/features/finance_controller/data/datasources/accounts_datasourse.dart';
import 'package:finance_system_controller/features/finance_controller/data/models/system_users/client_model.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/client.dart';

import '../../../domain/repositories/system_users/client_repository.dart';
import '../../datasources/clients_datasource.dart';

class ClientRepositoryImpl implements ClientRepository {
  final ClientsDatasource clientsDatasource;
  final AccountsDatasource accountsDatasource;

  ClientRepositoryImpl({required this.clientsDatasource, required this.accountsDatasource,});

  @override
  Future<bool> register(Client client) async {
    try {
      ClientModel model = ClientModel(username: client.username, password: client.password, fullName: client.fullName, passportSeriesAndNumber: client.passportSeriesAndNumber, idNumber: client.idNumber, phone: client.phone, email: client.email, isApproved: client.isApproved, role: "Client");
      clientsDatasource.insertClient(model);
      return true;
    } catch (e) {
      return false;
    }
  }
  
  @override
  Future<dynamic> login(String username, String password) async{
    try{
      final model = await clientsDatasource.login(password, username);
      return model;
    }catch (e){
      return null;
    }
  }

  @override
  Future<void> updateClientById(Client client) async {
    ClientModel model = ClientModel(username: client.username, password: client.password, fullName: client.fullName, passportSeriesAndNumber: client.passportSeriesAndNumber, idNumber: client.idNumber, phone: client.phone, email: client.email, isApproved: client.isApproved, role: "Client");
    await clientsDatasource.updateClient(model);
    return Future.value();
  }
  @override
  Future<void> deleteClient(int id) async{
    await clientsDatasource.deleteClient(id);
  }


  @override
  Future<List<Client>> getAllRegistrationRequests() async {
    final list = await clientsDatasource.getUnconfirmedClients();
    return list;
  }
}
