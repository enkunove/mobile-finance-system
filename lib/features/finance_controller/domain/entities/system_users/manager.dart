import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/system_user.dart';

class Manager extends User{
  @override
  String get role => "Manager";
  Manager(super.username, super.password);
}