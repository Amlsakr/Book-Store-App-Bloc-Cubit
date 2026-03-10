import 'package:book_store_app_bloc_cubit/domain/use_cases/home/home_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../core/data/api_response.dart';
import '../../../data/model/book.dart';

part 'home_event.dart';
part 'home_state.dart';

@Injectable()
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeUseCase _homeUseCase;

  HomeBloc(this._homeUseCase) : super(HomeLoading()) {
    on<LoadHomeData>(getListOfBooks);
  }

  Future<void> getListOfBooks(
    LoadHomeData event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final response = await _homeUseCase.execute();
      if (response.isSuccess) {
        emit(HomeDataSuccess(response));
      } else {
        emit(HomeError(ApiResponse.error(response.error)));
      }
    } catch (e) {
      emit(HomeError(ApiResponse.error(e.toString())));
    }
  }
}
