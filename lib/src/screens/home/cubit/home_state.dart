part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final BalanceModel totalBalance;
  final List<BalanceModel> balances;
  final List<TransactionModel> transactions;

  HomeLoaded({
    required this.totalBalance,
    required this.balances,
    required this.transactions,
  });
}

class HomeFailed extends HomeState {}

class NoPermissions extends HomeState {}
