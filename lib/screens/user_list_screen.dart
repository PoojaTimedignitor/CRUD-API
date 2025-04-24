
import 'package:flutter/material.dart';
import '../model/user_model.dart';
import '../service/user_service.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final UserService userService = UserService();
  int currentPage = 1;
  late Future<UserModel?> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = userService.getUsersData(page: currentPage);
  }

  void nextPage() {
    setState(() {
      currentPage++;
      futureUsers = userService.getUsersData(page: currentPage);
    });
  }

  void previousPage() {
    if (currentPage > 1) {
      setState(() {
        currentPage--;
        futureUsers = userService.getUsersData(page: currentPage);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users List of Data')),
      body: FutureBuilder<UserModel?>(
        future: futureUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData)
            return Center(child: Text('Error loading users'));

          final users = snapshot.data!.users;

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return ListTile(
                      title: Text("${user.firstName} ${user.lastName}"),
                      subtitle: Text(user.email),
                      trailing: Text(user.phone),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: previousPage,
                    child: const Text('Previous'),
                  ),
                  Text('Page ${snapshot.data!.currentPage} of ${snapshot.data!.totalPages}'),
                  ElevatedButton(
                    onPressed: currentPage < snapshot.data!.totalPages ? nextPage : null,
                    child: const Text('Next'),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
