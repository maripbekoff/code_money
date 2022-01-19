part of 'add_transaction_cubit.dart';

@immutable
abstract class AddTransactionState {}

class AddTransactionInitial extends AddTransactionState {}

class AddTransactionLoading extends AddTransactionState {}

class AddTransactionLoaded extends AddTransactionState {}

class AddTransactionFailed extends AddTransactionState {}
