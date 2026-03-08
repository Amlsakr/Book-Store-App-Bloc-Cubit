// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:book_store_app_bloc_cubit/core/di/firebase_module.dart'
    as _i685;
import 'package:book_store_app_bloc_cubit/data/auth_repository_impl.dart'
    as _i274;
import 'package:book_store_app_bloc_cubit/domain/repository/auth_repository.dart'
    as _i910;
import 'package:book_store_app_bloc_cubit/domain/use_cases/auth/get_auth_state_use_case.dart'
    as _i205;
import 'package:book_store_app_bloc_cubit/domain/use_cases/auth/login_use_case.dart'
    as _i1029;
import 'package:book_store_app_bloc_cubit/domain/use_cases/auth/signup_use_case.dart'
    as _i748;
import 'package:book_store_app_bloc_cubit/ui/auth/controllers/auth_form_cubit.dart'
    as _i61;
import 'package:book_store_app_bloc_cubit/ui/splash/controllers/auth_cubit.dart'
    as _i969;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final firebaseModule = _$FirebaseModule();
    gh.lazySingleton<_i59.FirebaseAuth>(() => firebaseModule.firebaseAuth);
    gh.lazySingleton<_i910.AuthRepository>(
      () => _i274.AuthRepoImpl(gh<_i59.FirebaseAuth>()),
    );
    gh.factory<_i205.GetAuthStateUseCase>(
      () => _i205.GetAuthStateUseCase(gh<_i910.AuthRepository>()),
    );
    gh.factory<_i1029.LoginUseCase>(
      () => _i1029.LoginUseCase(gh<_i910.AuthRepository>()),
    );
    gh.factory<_i748.SignupUseCase>(
      () => _i748.SignupUseCase(gh<_i910.AuthRepository>()),
    );
    gh.factory<_i969.AuthCubit>(
      () => _i969.AuthCubit(gh<_i205.GetAuthStateUseCase>()),
    );
    gh.factory<_i61.AuthFormCubit>(
      () => _i61.AuthFormCubit(
        gh<_i1029.LoginUseCase>(),
        gh<_i748.SignupUseCase>(),
      ),
    );
    return this;
  }
}

class _$FirebaseModule extends _i685.FirebaseModule {}
