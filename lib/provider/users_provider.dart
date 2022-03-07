import 'package:flutter/widgets.dart';
import 'package:flutter_http_testing/data/api_service.dart';
import 'package:flutter_http_testing/models/user.dart';

enum ResultState { Loading, NoData, HasData, Error }

class UsersProvider extends ChangeNotifier {
  final ApiService apiService;

  UsersProvider({required this.apiService}) {
    fetchUsers();
  }

  late List<User> _result;
  late ResultState _resultState;
  String _message = '';

  String get message => _message;

  List<User> get result => _result;

  ResultState get state => _resultState;

  Future<dynamic> fetchUsers() async {
    _resultState = ResultState.Loading;
    notifyListeners();

    try {
      final users = await apiService.getUsers();

      if (users.isEmpty) {
        _resultState = ResultState.NoData;
        notifyListeners();
        return _message = "No users found";
      } else {
        _resultState = ResultState.HasData;
        notifyListeners();
        return _result = users;
      }
    } catch (e) {
      _resultState = ResultState.Error;
      notifyListeners();
      return _message = 'Error -> $e';
    }
  }
}
