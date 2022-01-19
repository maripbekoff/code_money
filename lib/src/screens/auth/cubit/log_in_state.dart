part of 'log_in_cubit.dart';

@immutable
abstract class LogInState {}

class LogInInitial extends LogInState {}

class LogInLoading extends LogInState {}

class LogInLoaded extends LogInState {}

class LogInFailed extends LogInState {}
