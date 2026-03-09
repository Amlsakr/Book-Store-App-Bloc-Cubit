import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../core/strings/strings.dart';
import '../../../data/model/book.dart';

part 'favorite_book_state.dart';

@Injectable()
class FavoriteBookCubit extends HydratedCubit<FavoriteBookState> {
  FavoriteBookCubit() : super(FavoriteBookInitial());

  void toggleFavorite(Book book) {
    final isFav = isFavorite(book.title ?? "");

    if (isFav) {
      removeFavorites(book.title ?? "");
    } else {
      addBook(book);
    }
  }

  bool isFavorite(String title) {
    return state.favoritesResponse.any((b) => b.title == title);
  }

  void addBook(Book book) {
    final updated = List<Book>.from(state.favoritesResponse);
    updated.add(book);
    emit(FavoritesBookData(updated));
  }

  void removeFavorites(String title) {
    final updated = List<Book>.from(state.favoritesResponse);
    updated.removeWhere((book) => book.title == title);
    emit(FavoritesBookData(updated));
  }

  @override
  FavoriteBookState? fromJson(Map<String, dynamic> json) {
    return FavoritesBookData(
      (json[Strings.favoritesDB] as List<dynamic>)
          .map((book) => Book.fromJson(book))
          .toList(),
    );
  }

  @override
  Map<String, dynamic>? toJson(FavoriteBookState state) {
    return {
      Strings.favoritesDB: state.favoritesResponse
          .map((book) => book.toMap())
          .toList(),
    };
  }
}
