import 'package:bloc/bloc.dart';
import 'package:book_store_app_bloc_cubit/domain/use_cases/home/home_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../core/data/api_response.dart';
import '../../../core/strings/strings.dart';
import '../../../data/model/book.dart';

part 'home_state.dart';

@Injectable()
class HomeCubit extends Cubit<HomeState> {
  final HomeUseCase _homeUseCase;

  HomeCubit(this._homeUseCase) : super(HomeLoading());

  Future<void> getListOfBooks() async {
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
