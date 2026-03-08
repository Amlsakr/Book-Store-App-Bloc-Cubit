part of 'auth_cubit.dart';

@immutable
sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

final class AuthStateInitial extends AuthState {}

final class AuthStateAuthenticated extends AuthState {
  final User user;

  const AuthStateAuthenticated({required this.user});

  @override
  List<Object> get props => [user];
}

final class AuthStateUnAuthenticated extends AuthState {}
