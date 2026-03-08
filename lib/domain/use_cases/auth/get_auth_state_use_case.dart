import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../core/data/api_response.dart';
import '../../repository/auth_repository.dart';

@Injectable()
class GetAuthStateUseCase {
  final AuthRepository _authRepository;

  GetAuthStateUseCase(this._authRepository);

  Stream<User?> execute() => _authRepository.autState;
}
