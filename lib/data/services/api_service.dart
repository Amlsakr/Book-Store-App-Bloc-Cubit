import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../core/utils/utils.dart';
import '../model/book.dart';

@Injectable()
class ApiService {
  Future<List<Book>> getBooks() async {
    var url = Uri.parse(Utils.baseURL);
    final response = await http.get(
      url,
      headers: {Utils.headerAcceptKey: Utils.headerAcceptValue},
    );
    final List body = json.decode(response.body);
    return body.map((e) => Book.fromJson(e)).toList();
  }
}
