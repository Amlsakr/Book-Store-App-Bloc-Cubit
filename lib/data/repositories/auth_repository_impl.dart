import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../core/strings/strings.dart';
import '../../../domain/repository/auth_repository.dart';
import '../../core/data/api_response.dart';

@LazySingleton(as: AuthRepository)
class AuthRepoImpl extends AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepoImpl(this._firebaseAuth);

  @override
  Stream<User?> get autState {
    var user = _firebaseAuth.authStateChanges();

    return user;
  }

  @override
  Future<ApiResponse<User?>> signIn(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        return ApiResponse.success(credential.user);
      } else {
        throw Exception(Strings.serverError);
      }
    } on FirebaseAuthException catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<ApiResponse<User?>> signUp(String email, String password) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        return ApiResponse.success(credential.user);
      } else {
        throw Exception(Strings.serverError);
      }
    } on FirebaseAuthException catch (error) {
      throw Exception(error);
    }
  }
}
