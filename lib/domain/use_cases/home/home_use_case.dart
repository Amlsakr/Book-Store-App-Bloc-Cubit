import 'package:injectable/injectable.dart';

import '../../../core/data/api_response.dart';
import '../../../data/model/book.dart';
import '../../repository/home_repository.dart';

@Injectable()
class HomeUseCase {
  final HomeRepository _homeRepository;

  HomeUseCase(this._homeRepository);

  Future<ApiResponse<List<Book>>> execute() async {
    var homeResponse = await _homeRepository.getListOfBooks();

    return homeResponse;
  }
}
