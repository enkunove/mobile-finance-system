class Credit {
  final int id;
  final int clientId;
  final double percentage;
  final double amount;
  final double remainedToPay;

  Credit(
      {required this.percentage,
      required this.amount,
      required this.id,
      required this.clientId,
      required this.remainedToPay});
}
