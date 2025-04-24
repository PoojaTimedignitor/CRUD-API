/*
import 'package:flutter/material.dart';
import '../model/detail_user_model.dart';
import '../model/profile_model.dart';
import '../service/detail_user_service.dart';
import 'Detail_show_user_data.dart';

class DetailUserListScreen extends StatefulWidget {
  @override
  _DetailUserListScreenState createState() => _DetailUserListScreenState();
}

class _DetailUserListScreenState extends State<DetailUserListScreen> {
  final DetailUserService detailUserService = DetailUserService();
  int currentPage = 1;
  late Future<DetailUserModel?> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = detailUserService.getDetailUserData(page: currentPage);
  }

  void nextPage() {
    setState(() {
      currentPage++;
      futureUsers = detailUserService.getDetailUserData(page: currentPage);
    });
  }

  void previousPage() {
    if (currentPage > 1) {
      setState(() {
        currentPage--;
        futureUsers = detailUserService.getDetailUserData(page: currentPage);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User List')),
      body: FutureBuilder<DetailUserModel?>(
        future: futureUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: Text('Error loading users'));
          }

          final users = snapshot.data!.users;

          return Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Expanded(
                  child: Scrollbar(
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columnSpacing: 20,
                          headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
                          dataRowHeight: 60,
                          columns: const [
                            DataColumn(label: Text('ID')),
                            DataColumn(label: Text('First Name')),
                            DataColumn(label: Text('Last Name')),
                            DataColumn(label: Text('Email')),
                            DataColumn(label: Text('View')),
                          ],
                          rows: users.map((user) {
                            return DataRow(
                              cells: [
                                DataCell(Text(user.id)),
                                DataCell(Text(user.firstName)),
                                DataCell(Text(user.lastName)),
                                DataCell(Text(user.email)),
                                DataCell(
                                  ElevatedButton.icon(
                                    icon: const Icon(Icons.visibility),
                                    label: const Text("View"),
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    ),
                                    onPressed: () async {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (_) => const Center(child: CircularProgressIndicator()),
                                      );

                                      final userProfile = await detailUserService.getUserById(user.id);

                                      Navigator.pop(context); // close loading

                                      if (userProfile != null) {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => UserDetailPage(userProfile: userProfile),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Failed to load user profile')),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: previousPage,
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                    Text('Page ${snapshot.data!.currentPage} of ${snapshot.data!.totalPages}'),
                    IconButton(
                      onPressed: currentPage < snapshot.data!.totalPages ? nextPage : null,
                      icon: const Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
*/






import 'package:flutter/material.dart';
import '../model/detail_user_model.dart';
import '../model/profile_model.dart';
import '../service/detail_user_service.dart';
import 'Detail_show_user_data.dart';

class DetailUserListScreen extends StatefulWidget {
  @override
  _DetailUserListScreenState createState() => _DetailUserListScreenState();
}

class _DetailUserListScreenState extends State<DetailUserListScreen> {

  final DetailUserService detailUserService = DetailUserService();

  int currentPage = 1;
  late Future<DetailUserModel?> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = detailUserService.getDetailUserData(page: currentPage);
  }

  Future<void> refreshUsers() async {
    setState(() {
      futureUsers = detailUserService.getDetailUserData(page: currentPage);
    });
  }

  void nextPage() {
    setState(() {
      currentPage++;
      futureUsers = detailUserService.getDetailUserData(page: currentPage);
    });
  }

  void previousPage() {
    if (currentPage > 1) {
      setState(() {
        currentPage--;
        futureUsers = detailUserService.getDetailUserData(page: currentPage);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User List')),
      body: FutureBuilder<DetailUserModel?>(
        future: futureUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: Text('Error loading users'));
          }

          final users = snapshot.data!.users;

          return RefreshIndicator(
            onRefresh: refreshUsers,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Expanded(
                    child: Scrollbar(
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columnSpacing: 20,
                            headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
                            dataRowHeight: 60,
                            columns: const [
                              DataColumn(label: Text('ID')),
                              DataColumn(label: Text('First Name')),
                              DataColumn(label: Text('Last Name')),
                              DataColumn(label: Text('Email')),
                              DataColumn(label: Text('View')),
                            ],
                            rows: users.map((user) {
                              return DataRow(
                                cells: [
                                  DataCell(Text(user.id)),
                                  DataCell(Text(user.firstName)),
                                  DataCell(Text(user.lastName)),
                                  DataCell(Text(user.email)),
                                  DataCell(
                                    ElevatedButton.icon(
                                      icon: const Icon(Icons.visibility),
                                      label: const Text("View"),
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      ),
                                      onPressed: () async {
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (_) => const Center(child: CircularProgressIndicator()),
                                        );

                                        final userProfile = await detailUserService.getUserById(user.id);
                                        Navigator.pop(context); // Close loading spinner

                                        if (userProfile != null) {
                                          await Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => UserDetailPage(
                                                userProfile: userProfile,
                                                onDelete: refreshUsers, // <-- trigger refresh on return
                                              ),
                                            ),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('Failed to load user profile')),
                                          );
                                        }
                                      },


                                      // onPressed: () async {
                                      //   showDialog(
                                      //     context: context,
                                      //     barrierDismissible: false,
                                      //     builder: (_) => const Center(child: CircularProgressIndicator()),
                                      //   );
                                      //
                                      //   final userProfile = await detailUserService.getUserById(user.id);
                                      //
                                      //   Navigator.pop(context); // close loading
                                      //
                                      //   if (userProfile != null) {
                                      //     await Navigator.of(context).push(
                                      //       MaterialPageRoute(
                                      //         builder: (context) => UserDetailPage(
                                      //           userProfile: userProfile,
                                      //           onDelete: () => refreshUsers(), // <- refresh after delete
                                      //         ),
                                      //       ),
                                      //     );
                                      //   } else {
                                      //     ScaffoldMessenger.of(context).showSnackBar(
                                      //       const SnackBar(content: Text('Failed to load user profile')),
                                      //     );
                                      //   }
                                      // },
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          //onPressed: previousPage,
                          onPressed: currentPage > 1 ? previousPage : null,
                          child: const Text('Previous')),
                      // IconButton(
                      //   onPressed: previousPage,
                      //   icon: const Icon(Icons.arrow_back_ios),
                      // ),
                      const SizedBox(width: 8,),
                      Text('Page ${snapshot.data!.currentPage} of ${snapshot.data!.totalPages}'),
                      const SizedBox(width: 8,),
                      ElevatedButton(onPressed: currentPage < snapshot.data!.totalPages ? nextPage : null, child: const Text('Next')),
                      // IconButton(
                      //   onPressed: currentPage < snapshot.data!.totalPages ? nextPage : null,
                      //   icon: const Icon(Icons.arrow_forward_ios),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
