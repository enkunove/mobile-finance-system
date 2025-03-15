part of 'bank_info_bloc.dart';

@immutable
sealed class BankInfoState {}

final class BankInfoInitial extends BankInfoState {}

final class BankInfoLoading extends BankInfoState {}

final class BankInfoLoaded extends BankInfoState {
  final Account? account;
  BankInfoLoaded(this.account);
}
