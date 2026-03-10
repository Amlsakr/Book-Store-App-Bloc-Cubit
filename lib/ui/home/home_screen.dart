import 'package:book_store_app_bloc_cubit/core/di/injection.dart';
import 'package:book_store_app_bloc_cubit/ui/favorites/controllers/favorite_book_bloc.dart';
import 'package:book_store_app_bloc_cubit/ui/home/controllers/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/strings/strings.dart';
import '../../core/themes/colors.dart';
import '../../core/themes/theme.dart';
import '../../data/model/book.dart';
import '../details/book_details.dart';
import '../favorites/favorites_screen.dart';
import 'book_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var currentMode = MediaQuery.platformBrightnessOf(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<HomeBloc>()..add(LoadHomeData())),
        BlocProvider(create: (_) => getIt<FavoriteBookBloc>()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(Strings.appBarTitle),
          backgroundColor: AppColors.chestnutRoseApprox,
          foregroundColor: Colors.white,
          actions: [
            BlocBuilder<FavoriteBookBloc, FavoriteBookState>(
              builder: (context, state) {
                return IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: context.read<FavoriteBookBloc>(),
                          child: FavoritesScreen(),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.bookmark_add, color: Colors.white),
                );
              },
            ),
          ],
        ),
        backgroundColor: currentMode == Brightness.light
            ? Colors.white
            : Colors.black,
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            switch (state) {
              case HomeLoading():
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.chestnutRoseApprox,
                  ),
                );
              case HomeDataSuccess():
                return ListView.builder(
                  itemCount: state.homeResponse.data?.length,
                  itemBuilder: (context, index) {
                    return BookItem(
                      book: state.homeResponse.data![index],
                      onSelectBook: (Book book) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                              value: context.read<FavoriteBookBloc>(),
                              child: BookDetails(book: book),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              case HomeError():
                return Center(
                  child: Text(
                    "${state.errorMessage.error}",
                    style: AppThemes.semiBold18.copyWith(
                      color: currentMode == Brightness.light
                          ? AppColors.sharkApprox
                          : Colors.white,
                    ),
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
