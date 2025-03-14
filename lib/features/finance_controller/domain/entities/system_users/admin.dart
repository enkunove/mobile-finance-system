import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/system_user.dart';

class Admin extends User{
  @override
  String get role => "Admin";
  Admin(super.username, super.password);
}