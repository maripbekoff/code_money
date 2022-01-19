part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final SpreadsheetModel spreadsheet;
  final List<BalanceModel> balances;
  final List<TransactionModel> transactions;

  HomeLoaded({
    required this.spreadsheet,
    required this.balances,
    required this.transactions,
  });
}

class HomeFailed extends HomeState {}
