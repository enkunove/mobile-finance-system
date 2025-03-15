import 'package:finance_system_controller/features/finance_controller/data/models/system_users/client_model.dart';
import '../../domain/entities/bank.dart';

class BankModel extends Bank {
  BankModel({
    required super.id,
    required super.type,
    required super.name,
    required super.pin,
    required super.bic,
    required super.address,
    List<ClientModel>? clients,
  }) : super(
    clients: clients ?? [],
  );

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'name': name,
      'pin': pin,
      'bic': bic,
      'address': address,
      'clients': clients.isEmpty ? null : clients.map((c) => toMap()).toList()
    };
  }

  factory BankModel.fromMap(Map<String, dynamic> map) {
    return BankModel(
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
