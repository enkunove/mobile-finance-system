import 'dart:convert';
import 'package:finance_system_controller/features/finance_controller/data/datasources/accounts_datasourse.dart';
import 'package:finance_system_controller/features/finance_controller/data/models/system_users/client_model.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/credit.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/client.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/transfer.dart';

import '../../../domain/entities/account.dart';
import '../../../domain/repositories/system_users/client_repository.dart';
import '../../datasources/clients_datasource.dart';
import '../../models/account_model.dart';
import '../../models/credit_model.dart';
import '../../models/transfer_model.dart';

class ClientRepositoryImpl implements ClientRepository {
  final ClientsDatasource clientsDatasource;
  final AccountsDatasource accountsDatasource;

  ClientRepositoryImpl({required this.clientsDatasource, required this.accountsDatasource,});

  @override
  Future<bool> register(Client client) async {
    try {
      ClientModel model = ClientModel(username: client.username, password: client.password, fullName: client.fullName, passportSeriesAndNumber: client.passportSeriesAndNumber, idNumber: client.idNumber, phone: client.phone, email: client.email);
      clientsDatasource.insertClient(model);
      return true;
    } catch (e) {
      return false;
    }
  }
  
  @override
  Future<Client?> login(String username, String password) async{
    try{
      final model = await clientsDatasource.login(password, username);
      return model as Client;
    }catch (e){
      return null;
    }
  }
}
