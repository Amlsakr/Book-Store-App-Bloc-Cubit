part of 'favorite_book_bloc.dart';

@immutable
sealed class FavoriteBookState extends Equatable {
  final List<Book> favoritesResponse;

  const FavoriteBookState(this.favoritesResponse);

  @override
  List<Object> get props => [favoritesResponse];
}

final class FavoriteBookInitial extends FavoriteBookState {
  FavoriteBookInitial() : super([]);
}

final class FavoritesBookData extends FavoriteBookState {
  const FavoritesBookData(super.favoritesResponse);
}
