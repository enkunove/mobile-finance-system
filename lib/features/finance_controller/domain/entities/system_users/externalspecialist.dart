import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/system_user.dart';

class ExternalSpecialist extends User{

  @override
  String get role => "ExternalSpecialist";
  ExternalSpecialist(super.username, super.password);
}