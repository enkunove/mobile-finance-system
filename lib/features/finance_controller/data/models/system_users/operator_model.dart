import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/manager.dart';

class OperatorModel extends Manager{
  final String role;
  OperatorModel(super.username, super.password, {required this.role});

  factory OperatorModel.fromMap(Map<String, dynamic> map){
    return OperatorModel(map['username'], map['password'], role: map['role']);
  }

  Map<String, dynamic> toMap(){
    return{
      'username' : username,
      'password' : password,
      'role' : role
    };
  }
}