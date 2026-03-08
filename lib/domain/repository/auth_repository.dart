import 'package:firebase_auth/firebase_auth.dart';

import '../../core/data/api_response.dart';

abstract class AuthRepository {
  Future<ApiResponse<User?>> signIn(String email, String password);

  Future<ApiResponse<User?>> signUp(String email, String password);

  Stream<User?> get autState;
}
