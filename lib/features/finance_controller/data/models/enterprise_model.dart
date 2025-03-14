import 'package:finance_system_controller/features/finance_controller/data/models/system_users/client_model.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/client.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/bank.dart';

import '../../domain/entities/enterprise.dart';

class EnterpriseModel extends Enterprise {
  EnterpriseModel({
    required int id,
    required String type,
    required String name,
    required String pin,
    required String bic,
    required String address,
    List<ClientModel>? clients,
  }) : super(
    id: id,
    type: type,
    name: name,
    pin: pin,
    bic: bic,
    address: address,
    clients: clients ?? []
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'pin': pin,
      'bic': bic,
      'address': address,
      'clients': clients.isEmpty ? null : clients.map((c) => toMap()).toList()
    };
  }

  factory EnterpriseModel.fromMap(Map<String, dynamic> map) {
    return EnterpriseModel(
      id: map['id'],
      type: map['type'],
      name: map['name'],
      pin: map['pin'],
      bic: map['bic'],
      address: map['address'],
      clients: map['clients'] != null
          ? List<ClientModel>.from(map['clients']?.map((client) => ClientModel.fromMap(client)))
          : [],
    );
  }
}
