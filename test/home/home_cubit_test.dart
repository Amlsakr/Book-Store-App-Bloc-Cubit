import 'package:bloc_test/bloc_test.dart';
import 'package:book_store_app_bloc_cubit/core/data/api_response.dart';
import 'package:book_store_app_bloc_cubit/domain/use_cases/home/home_use_case.dart';
import 'package:book_store_app_bloc_cubit/ui/home/controllers/home_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeUseCase extends Mock implements HomeUseCase {}

void main() {
  late MockHomeUseCase homeUseCase;
  late HomeCubit homeCubit;

  setUp(() {
    homeUseCase = MockHomeUseCase();
    homeCubit = HomeCubit(homeUseCase);
  });
  blocTest<HomeCubit, HomeState>(
    'emits homeDataSuccess when books are fetched successfully',
    build: () {
      when(
        () => homeUseCase.execute(),
      ).thenAnswer((_) async => ApiResponse.success([]));
      return homeCubit;
    },
    act: (homeCubit) => homeCubit.getListOfBooks(),
    expect: () => [isA<HomeDataSuccess>()],
  );

  blocTest(
    'emits homeError when usecase return error',
    build: () {
      when(
        () => homeUseCase.execute(),
      ).thenAnswer((_) async => ApiResponse.error("Api Error"));
      return homeCubit;
    },
    act: (homeCubit) => homeCubit.getListOfBooks(),
    expect: () => [isA<HomeError>()],
  );
}
