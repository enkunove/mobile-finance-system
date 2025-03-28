import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/externalspecialist.dart';

class ExternalSpecialistModel extends ExternalSpecialist {
  ExternalSpecialistModel(
      {required super.username,
      required super.password,
      required super.fullName,
      required super.passportSeriesAndNumber,
      required super.idNumber,
      required super.phone,
      required super.email,
      super.isApproved,
      required super.role
      });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'fullName': fullName,
      'passportSeriesAndNumber': passportSeriesAndNumber,
      'phone': phone,
      'email': email,
      'role' : "ExternalSpecialist",
      'isApproved': isApproved ? 1 : 0,
    };
  }

  factory ExternalSpecialistModel.fromMap(Map<String, dynamic> map) {
    return ExternalSpecialistModel(
      username: map['username'] as String,
      password: map['password'] as String,
      fullName: map['fullName'] as String,
      passportSeriesAndNumber: map['passportSeriesAndNumber'] as String,
      idNumber: map['idNumber'] as int,
      phone: map['phone'] as String,
      email: map['email'] as String,
        role: map['role']

    );
  }
}
