
import '../../domain/entities/enterprise.dart';

class EnterpriseModel extends Enterprise {
  EnterpriseModel({
    required super.id,
    required super.type,
    required super.name,
    required super.pin,
    required super.bic,
    required super.address,
    super.specialistId,
    super.bankId
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'pin': pin,
      'bic': bic,
      'address': address,
      'specialistId' : specialistId,
      'bankId' : bankId
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
      specialistId: map['specialistId'],
      bankId: map['bankId']
    );
  }
}
