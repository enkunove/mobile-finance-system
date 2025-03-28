import '../../domain/entities/bank.dart';

class BankModel extends Bank {
  BankModel({
    required super.id,
    required super.type,
    required super.name,
    required super.pin,
    required super.bic,
    required super.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'name': name,
      'pin': pin,
      'bic': bic,
      'address': address,
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
    );
  }
}
