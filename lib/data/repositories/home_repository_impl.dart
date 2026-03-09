import 'package:injectable/injectable.dart';

import '../../core/data/api_response.dart';
import '../../core/strings/strings.dart';
import '../../core/utils/utils.dart';
import '../../domain/repository/home_repository.dart';
import '../model/book.dart';
import '../services/api_service.dart';

@LazySingleton(as: HomeRepository)
class HomeRepoImpl extends HomeRepository {
  final ApiService apiService;

  HomeRepoImpl(this.apiService);

  @override
  Future<ApiResponse<List<Book>>> getListOfBooks() async {
    var isConnected = await Utils.isConnected();
    if (isConnected) {
      try {
        final books = await apiService.getBooks();
        return ApiResponse.success(books);
      } catch (e) {
        throw Exception(Strings.serverError);
      }
    } else {
      throw Exception(Strings.noInternetConnection);
    }
  }
}
