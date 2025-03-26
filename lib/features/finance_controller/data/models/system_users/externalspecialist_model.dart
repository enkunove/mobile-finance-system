import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/externalspecialist.dart';

class ExternalSpecialistModel extends ExternalSpecialist {
  ExternalSpecialistModel(
      super.username,
      super.password, {
        required super.fullName,
        required super.passportSeriesAndNumber,
        required super.idNumber,
        required super.phone,
        required super.email,
        required super.isApproved,
      });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'fullName': fullName,
      'passportSeriesAndNumber': passportSeriesAndNumber,
      'idNumber': idNumber,
      'phone': phone,
      'email': email,
      'isApproved': isApproved? 1:0,
    };
  }

  factory ExternalSpecialistModel.fromMap(Map<String, dynamic> map) {
    return ExternalSpecialistModel(
      map['username'] as String,
      map['password'] as String,
      fullName: map['fullName'] as String,
      passportSeriesAndNumber: map['passportSeriesAndNumber'] as String,
      idNumber: map['idNumber'] as int,
      phone: map['phone'] as String,
      email: map['email'] as String,
      isApproved: map['isApproved'] == 1? true:false,
    );
  }
}
