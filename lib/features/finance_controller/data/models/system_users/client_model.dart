import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/client.dart';
import '../transfer_model.dart';
import '../account_model.dart';
import '../credit_model.dart';

class ClientModel extends Client {
  @override
  final String fullName;
  @override
  final String passportSeriesAndNumber;
  @override
  final int idNumber;
  @override
  final String phone;
  @override
  final String email;
  @override
  bool isApproved;
  final String role;


  ClientModel({
    required String username,
    required String password,
    required this.fullName,
    required this.passportSeriesAndNumber,
    required this.phone,
    this.idNumber = 0,
    required this.email,
    required this.isApproved,
    required this.role
  }) :
        super(username, password,
          fullName: fullName,
          passportSeriesAndNumber: passportSeriesAndNumber,
          idNumber: idNumber,
          phone: phone,
          email: email,
          isApproved: isApproved,
      );

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'fullName': fullName,
      'passportSeriesAndNumber': passportSeriesAndNumber,
      'phone': phone,
      'email': email,
      'isApproved' : isApproved? 1: 0,
      'role' : role
    };
  }


  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      username: map['username'],
      password: map['password'],
      fullName: map['fullName'],
      passportSeriesAndNumber: map['passportSeriesAndNumber'],
      idNumber: map['idNumber'],
      phone: map['phone'],
      email: map['email'],
      isApproved: map['isApproved'] == 1,
      role: map['role']
    );
  }

}
