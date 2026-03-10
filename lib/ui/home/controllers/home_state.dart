part of 'home_bloc.dart';

@immutable
sealed class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

final class HomeLoading extends HomeState {}

final class HomeDataSuccess extends HomeState {
  final ApiResponse<List<Book>> homeResponse;

  HomeDataSuccess(this.homeResponse);

  @override
  List<Object> get props => [homeResponse];
}

final class HomeError extends HomeState {
  final ApiResponse<String> errorMessage;

  HomeError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
