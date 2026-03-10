import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../domain/use_cases/auth/get_auth_state_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@Injectable()
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetAuthStateUseCase _getAuthStateUseCase;
  StreamSubscription? _subscription;

  AuthBloc(this._getAuthStateUseCase) : super(AuthStateInitial()) {
    on<ListenAuthState>(listenAuthState);
  }

  void listenAuthState(ListenAuthState event, Emitter<AuthState> emit) {
    _subscription = _getAuthStateUseCase.execute().listen((user) {
      if (user == null) {
        emit(AuthStateUnAuthenticated());
      } else {
        emit(AuthStateAuthenticated(user: user));
      }
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
