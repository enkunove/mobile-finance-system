class Credit {
  final int id;
  final int clientId;
  final int accountId;
  final int months;
  final double percentage;
  final double amount;
  final double remainedToPay;
  final bool isApproved;

  Credit(
      {required this.percentage,
      required this.amount,
      required this.months,
      required this.id,
      required this.clientId,
      required this.accountId,
      required this.remainedToPay,
      required this.isApproved
      });
}
