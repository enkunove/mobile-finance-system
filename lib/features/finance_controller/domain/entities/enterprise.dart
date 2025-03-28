class Enterprise{
  int id;
  final String type;
  final String name;
  final String pin;
  final String bic;
  final String address;
  int? bankId;
  int? specialistId;

  Enterprise(
      {
        required this.type,
        required this.pin,
        required this.address,
        required this.name,
        required this.bic,
        this.id = 0,
        this.specialistId,
        this.bankId
      });

  @override
  String toString() {
    return "id: $id, type: $type, pin: $pin, address: $address, name: $name, bic: $bic";
  }
}
