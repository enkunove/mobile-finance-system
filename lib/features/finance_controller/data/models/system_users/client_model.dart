import 'dart:convert';
import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/client.dart';
import '../transfer_model.dart';
import '../account_model.dart';
import '../credit_model.dart';

class ClientModel extends Client {
  final String fullName;
  final String passportSeriesAndNumber;
  final int idNumber;
  final String phone;
  final String email;
  final List<AccountModel> accounts;
  final List<CreditModel> credits;
  final List<TransferModel> transfers;

  ClientModel({
    required String username,
    required String password,
    required this.fullName,
    required this.passportSeriesAndNumber,
    required this.phone,
    this.idNumber = 0,
    required this.email,
    List<AccountModel>? accounts,
    List<CreditModel>? credits,
    List<TransferModel>? transfers,
  }) : accounts = accounts ?? [],
        credits = credits ?? [],
        transfers = transfers ?? [],
        super(username, password,
          fullName: fullName,
          passportSeriesAndNumber: passportSeriesAndNumber,
          phone: phone,
          email: email);

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'fullName': fullName,
      'passportSeriesAndNumber': passportSeriesAndNumber,
      'phone': phone,
      'email': email,
      'accounts': accounts.isEmpty ? null : accounts.map((a) => a.toMap()).toList(),
      'credits': credits.isEmpty ? null : credits.map((c) => c.toMap()).toList(),
      'transfers': transfers.isEmpty ? null : transfers.map((t) => t.toMap()).toList(),
    };
  }


  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      username: map['username'],  // извлекаем username из Map
      password: map['password'],  // извлекаем password
      fullName: map['fullName'],
      passportSeriesAndNumber: map['passportSeriesAndNumber'],
      idNumber: map['idNumber'],
      phone: map['phone'],
      email: map['email'],
      accounts: map['accounts'] != null
          ? (map['accounts'] as List)
          .map((a) => AccountModel.fromMap(a))
          .toList()
          : [],  // If null, return an empty list
      credits: map['credits'] != null
          ? (map['credits'] as List)
          .map((c) => CreditModel.fromMap(c))
          .toList()
          : [],  // If null, return an empty list
      transfers: map['transfers'] != null
          ? (map['transfers'] as List)
          .map((t) => TransferModel.fromMap(t))
          .toList()
          : [],  // If null, return an empty list
    );
  }

}
