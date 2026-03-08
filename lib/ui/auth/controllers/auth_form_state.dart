part of 'auth_form_cubit.dart';

@immutable
sealed class AuthFormState extends Equatable {
  @override
  List<Object> get props => [];
}

final class AuthFormInitial extends AuthFormState {}

final class AuthFormLoading extends AuthFormState {}

final class AuthFormSuccess extends AuthFormState {
  final ApiResponse<User?> user;

  AuthFormSuccess(this.user);

  @override
  List<Object> get props => [user];
}

final class AuthFormFailure extends AuthFormState {
  final String message;

  AuthFormFailure(this.message);

  @override
  List<Object> get props => [message];
}
