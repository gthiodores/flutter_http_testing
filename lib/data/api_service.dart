import 'dart:convert';

import 'package:flutter_http_testing/models/user.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = "https://jsonplaceholder.typicode.com/";
  static const String _usersUrl = _baseUrl + "users";
  static const String _albumsUrl = _baseUrl + "albums";
  static const String _todosUrl = _baseUrl + "todos";

  Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse(_usersUrl));

    if (response.statusCode == 200) {
      final List list = json.decode(response.body);
      return list.map((body) => User.fromJson(body)).toList();
    } else {
      throw Exception("Failed to load users");
    }
  }
}
