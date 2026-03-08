import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../core/data/api_response.dart';
import '../../repository/auth_repository.dart';

@Injectable()
class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  Future<ApiResponse<User?>> execute(String email, String password) {
    return _authRepository.signIn(email, password);
  }
}
