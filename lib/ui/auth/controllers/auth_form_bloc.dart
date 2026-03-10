import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../core/data/api_response.dart';
import '../../../core/strings/strings.dart';
import '../../../domain/use_cases/auth/login_use_case.dart';
import '../../../domain/use_cases/auth/signup_use_case.dart';


part 'auth_form_state.dart';
part 'auth_form_event.dart';

@Injectable()
class AuthFormCubit extends Bloc<AuthFormEvent, AuthFormState> {
  final LoginUseCase _loginUseCase;
  final SignupUseCase _signupUseCase;

  AuthFormCubit(this._loginUseCase, this._signupUseCase)
    : super(AuthFormInitial()) {
    on<LoginEvent>(login);
    on<SignupEvent>(signup);
  }

  Future<void> login(LoginEvent event, Emitter<AuthFormState> emit) async {
    emit(AuthFormLoading());
    try {
      var result = await _loginUseCase.execute(event.email, event.password);
      if (result.data == null) {
        throw Exception(Strings.loginError);
      }
      emit(AuthFormSuccess(result));
    } catch (e) {
      emit(AuthFormFailure(e.toString()));
    }
  }

  Future<void> signup(SignupEvent event, Emitter<AuthFormState> emit) async {
    emit(AuthFormLoading());
    try {
      var result = await _signupUseCase.execute(event.email, event.password);
      if (result.data == null) {
        throw Exception(Strings.signupError);
      }
      emit(AuthFormSuccess(result));
    } catch (e) {
      emit(AuthFormFailure(e.toString()));
    }
  }
}
