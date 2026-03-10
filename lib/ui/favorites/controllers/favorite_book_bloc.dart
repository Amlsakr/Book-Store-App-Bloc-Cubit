import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../core/strings/strings.dart';
import '../../../data/model/book.dart';

part 'favorite_book_event.dart';
part 'favorite_book_state.dart';

@Injectable()
class FavoriteBookBloc
    extends HydratedBloc<FavoriteBookEvent, FavoriteBookState> {
  FavoriteBookBloc() : super(FavoriteBookInitial()) {
    on<ToggleFavoriteBook>(toggleFavorite);
  }

  void toggleFavorite(
    ToggleFavoriteBook event,
    Emitter<FavoriteBookState> emit,
  ) {
    final isFav = isFavorite(event.book.number ?? 0);

    if (isFav) {
      removeFavorites(event.book.number ?? 0);
    } else {
      addBook(event.book);
    }
  }

  bool isFavorite(int number) {
    return state.favoritesResponse.any((b) => b.number == number);
  }

  void addBook(Book book) {
    final updated = List<Book>.from(state.favoritesResponse);
    updated.add(book);
    emit(FavoritesBookData(updated));
  }

  void removeFavorites(int number) {
    final updated = List<Book>.from(state.favoritesResponse);
    updated.removeWhere((book) => book.number == number);
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
