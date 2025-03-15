part of 'bank_info_bloc.dart';

@immutable
sealed class BankInfoEvent {}

class FetchBankInfo extends BankInfoEvent {}
