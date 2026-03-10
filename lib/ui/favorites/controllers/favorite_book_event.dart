part of 'favorite_book_bloc.dart';
@immutable
sealed class FavoriteBookEvent {}

class ToggleFavoriteBook extends FavoriteBookEvent {
  final Book book ;
  ToggleFavoriteBook(this.book);
}
