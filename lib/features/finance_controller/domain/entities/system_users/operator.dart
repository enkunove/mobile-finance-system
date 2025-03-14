import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/system_user.dart';

class Operator extends User{
  @override
  String get role => "Operator";
  Operator(super.username, super.password);
}