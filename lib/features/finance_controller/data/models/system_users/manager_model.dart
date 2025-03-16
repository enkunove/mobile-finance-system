import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/manager.dart';

class ManagerModel extends Manager{
  final String role;
  ManagerModel(super.username, super.password, {required this.role});

  factory ManagerModel.fromMap(Map<String, dynamic> map){
    return ManagerModel(map['username'], map['password'], role: map['role']);
  }

  Map<String, dynamic> toMap(){
    return{
      'username' : username,
      'password' : password,
      'role' : role
    };
  }
}