import 'package:bloc_test/bloc_test.dart';
import 'package:book_store_app_bloc_cubit/core/data/api_response.dart';
import 'package:book_store_app_bloc_cubit/domain/use_cases/home/home_use_case.dart';
import 'package:book_store_app_bloc_cubit/ui/home/controllers/home_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeUseCase extends Mock implements HomeUseCase {}

void main() {
  late MockHomeUseCase homeUseCase;
  late HomeBloc homeBloc;

  setUp(() {
    homeUseCase = MockHomeUseCase();
    homeBloc = HomeBloc(homeUseCase);
  });
  tearDown(() {
    homeBloc.close();
  });
  blocTest<HomeBloc, HomeState>(
    'emits homeDataSuccess when books are fetched successfully',
    build: () {
      when(
        () => homeUseCase.execute(),
      ).thenAnswer((_) async => ApiResponse.success([]));
      return homeBloc;
    },
    act: (homeBloc) => homeBloc.add(LoadHomeData()),
    expect: () => [isA<HomeDataSuccess>()],
  );

  blocTest(
    'emits homeError when usecase return error',
    build: () {
      when(
        () => homeUseCase.execute(),
      ).thenAnswer((_) async => ApiResponse.error("Api Error"));
      return homeBloc;
    },
    act: (homeBloc) => homeBloc.add(LoadHomeData()),
    expect: () => [isA<HomeError>()],
  );
}
