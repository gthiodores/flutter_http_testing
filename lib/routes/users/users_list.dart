import 'package:flutter/material.dart';
import 'package:flutter_http_testing/provider/users_provider.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';

class UsersList extends StatelessWidget {
  const UsersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UsersProvider>(
      builder: (context, state, _) {
        switch (state.state) {
          case ResultState.Loading:
            return _buildLoadingWidget();
          case ResultState.NoData:
            return _buildEmptyContentWidget();
          case ResultState.Error:
            return _buildErrorWidget(
              retryFetch: () {
                state.fetchUsers();
              },
            );
          case ResultState.HasData:
            return _buildSuccessStateWidgets(
              userLists: state.result,
              onRefreshRequested: () {
                state.fetchUsers();
              },
            );
        }
      },
    );
  }

  Widget _buildLoadingWidget() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorWidget({Function? retryFetch}) {
    return Center(
      child: Column(
        children: [
          const Text("Error occurred when fetching data!"),
          ElevatedButton(
              onPressed: () {
                retryFetch?.call();
              },
              child: const Text("Retry"))
        ],
      ),
    );
  }

  Widget _buildEmptyContentWidget() {
    return const Center(
      child: Text("No data found"),
    );
  }

  Widget _buildSuccessStateWidgets({
    required List<User> userLists,
    Function? onRefreshRequested,
  }) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            onRefreshRequested?.call();
          },
          child: const Text("Refresh Data"),
        ),
        Expanded(child: _buildUserList(userLists)),
      ],
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
