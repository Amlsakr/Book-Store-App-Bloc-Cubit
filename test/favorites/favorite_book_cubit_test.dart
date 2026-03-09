import 'package:bloc_test/bloc_test.dart';
import 'package:book_store_app_bloc_cubit/data/model/book.dart';
import 'package:book_store_app_bloc_cubit/ui/favorites/controllers/favorite_book_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockStorage extends Mock implements Storage {}

void main() {
  late MockStorage mockStorage = MockStorage();
  late FavoriteBookCubit favoriteBookCubit = FavoriteBookCubit();
  final Book book = Book(
    number: 1,
    title: "Clean Code",
    originalTitle: "Clean Code",
    releaseDate: "2000",
    description: "Software Book",
    pages: 500,
    cover: "",
    index: 1,
  );
  setUp(() {
    mockStorage = MockStorage();
    HydratedBloc.storage = mockStorage;
    when(() => mockStorage.write(any(), any())).thenAnswer((_) async {});
    when(() => mockStorage.read(any())).thenReturn(null);
    favoriteBookCubit = FavoriteBookCubit();
  });

  tearDown(() {
    favoriteBookCubit.close();
  });
  blocTest<FavoriteBookCubit, FavoriteBookState>(
    'add book to favorites',
    build: () => favoriteBookCubit,
    act: (favoriteBookCubit) => favoriteBookCubit.addBook(book),
    expect: () => [isA<FavoritesBookData>()],
  );
  blocTest<FavoriteBookCubit, FavoriteBookState>(
    'remove books from favorites',
    build: () {
      favoriteBookCubit.addBook(book);
      return favoriteBookCubit;
    },
    act: (favoriteBookCubit) => favoriteBookCubit.removeFavorites(1),
    expect: () => [isA<FavoritesBookData>()],
  );
  blocTest<FavoriteBookCubit, FavoriteBookState>(
    "toggle favorite book when book not favorite",
    build: () => favoriteBookCubit,
    act: (favoriteBookCubit) => favoriteBookCubit.toggleFavorite(book),
    expect: () => [isA<FavoritesBookData>()],
  );

  blocTest<FavoriteBookCubit, FavoriteBookState>(
    "toggle favorite book when book is favorite",
    build: () {
      favoriteBookCubit.addBook(book);
      return favoriteBookCubit;
    },
    act: (favoriteBookCubit) => favoriteBookCubit.toggleFavorite(book),
    expect: () => [isA<FavoritesBookData>()],
  );
}
