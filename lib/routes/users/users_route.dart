import 'package:flutter/material.dart';
import 'package:flutter_http_testing/data/api_service.dart';

import '../../models/user.dart';

class UsersRoute extends StatelessWidget {
  const UsersRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My AppBar"),
      ),
      body: FutureBuilder<List<User>>(
        future: ApiService().getUsers(),
        builder: (context, snapshot) {
          final connectionState = snapshot.connectionState;
          switch (connectionState) {
            case ConnectionState.none:
              return const Center(child: Text("Not connected"));
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.active:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              return snapshot.data == null
                  ? Container()
                  : _buildUserList(snapshot.data!);
          }
        },
      ),
    );
  }

  Widget _buildUserList(List<User> users) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(users[index].name),
          subtitle: Text(users[index].email),
        );
      },
      itemCount: users.length,
    );
  }
}
