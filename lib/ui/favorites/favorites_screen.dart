import 'package:book_store_app_bloc_cubit/ui/favorites/controllers/favorite_book_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/strings/strings.dart';
import '../../core/themes/colors.dart';
import '../../core/themes/theme.dart';
import '../../data/model/book.dart';
import '../details/book_details.dart';
import '../home/book_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var currentMode = MediaQuery.platformBrightnessOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.favoritesBook),
        backgroundColor: AppColors.chestnutRoseApprox,
        foregroundColor: Colors.white,
      ),
      backgroundColor: currentMode == Brightness.light
          ? Colors.white
          : Colors.black,
      body: BlocBuilder<FavoriteBookCubit, FavoriteBookState>(
        builder: (context, state) {
          switch (state) {
            case FavoriteBookInitial():
              return Center(
                child: Text(
                  Strings.noFavorites,
                  style: AppThemes.semiBold18.copyWith(
                    color: currentMode == Brightness.light
                        ? AppColors.sharkApprox
                        : Colors.white,
                  ),
                ),
              );
            case FavoritesBookData():
              {
                var content = (state.favoritesResponse.isNotEmpty)
                    ? ListView.builder(
                        itemCount: state.favoritesResponse.length,
                        itemBuilder: (context, index) {
                          return BookItem(
                            book: state.favoritesResponse[index],
                            onSelectBook: (Book book) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                    value: context.read<FavoriteBookCubit>(),
                                    child: BookDetails(book: book),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          Strings.noFavorites,
                          style: AppThemes.semiBold18.copyWith(
                            color: currentMode == Brightness.light
                                ? AppColors.sharkApprox
                                : Colors.white,
                          ),
                        ),
                      );
                return content;
              }
          }
        },
      ),
    );
  }
}
