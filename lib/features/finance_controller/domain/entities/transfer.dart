
class Transfer{
  final dynamic source;
  final dynamic target;
  final double amount;
  DateTime dateTime;

  Transfer(this.source, this.target, this.amount) : dateTime = DateTime.now();
}