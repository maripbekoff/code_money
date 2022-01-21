part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {
  final String initialRoute = RoutingConst.splashRoute;
}

class Authenticated extends AuthState {
  final String initialRoute = RoutingConst.mainRoute;
}

class UnAuthenticated extends AuthState {
  final String initialRoute = RoutingConst.authRoute;
}

class ForceUpdate extends AuthState {
  final String initialRoute = RoutingConst.forceUpdateRoute;
}
