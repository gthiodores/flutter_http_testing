import 'package:flutter/material.dart';
import 'package:flutter_http_testing/data/api_service.dart';
import 'package:flutter_http_testing/provider/users_provider.dart';
import 'package:flutter_http_testing/routes/users/users_list.dart';
import 'package:provider/provider.dart';

class UsersRoute extends StatelessWidget {
  const UsersRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My AppBar"),
      ),
      body: ChangeNotifierProvider<UsersProvider>(
        child: const UsersList(),
        create: (context) => UsersProvider(apiService: ApiService()),
      ),
    );
  }
}
