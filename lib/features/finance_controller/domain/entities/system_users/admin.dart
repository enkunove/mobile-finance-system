import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/system_user.dart';

class Admin extends User {
  Admin(
      {required super.username,
      required super.password,
      required super.fullName,
      required super.passportSeriesAndNumber,
      required super.idNumber,
      required super.phone,
      required super.email,
      required super.role

      });

  @override
  String get role => "Admin";
}
