
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

  final TextEditingController searchController = TextEditingController();
  List<UserProfile>? searchedUsers;
  bool isSearching = false;


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



  void showCreatePostDialog(BuildContext context) {
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();

    final formKey = GlobalKey<FormState>();


    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Create User"),
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                    controller: firstNameController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        labelText: "First Name"
                    ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (firstName){
                    if (firstName == null || firstName.isEmpty) {
                      return 'First Name is required';
                    }
                    return null;
                  },
                ),
                TextFormField(
                    controller: lastNameController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(labelText: "Last Name"),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (lastName){
                      if(lastName == null || lastName.isEmpty){
                        return 'Last Name is required';
                      }
                      return null;
                  },
                ),
                TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        labelText: "Email"
                    ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email){
                      if(email == null || email.isEmpty){
                        return 'Email is required';
                      }
                      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');
                      if (!emailRegex.hasMatch(email)) {
                        return 'Enter a valid email';
                      }
                      return null;
                  },
                ),
                TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                        labelText: "Phone"
                    ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLength: 10,
                  validator: (phone){
                      if(phone == null || phone.isEmpty){
                        return 'Phone Number is required';
                      }
                      if (!RegExp(r'^\d{10}$').hasMatch(phone)) {
                        return 'Phone number must be exactly 10 digits';
                      }
                      return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              if(formKey.currentState!.validate()) {
                final createProfile = UserProfile(
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  email: emailController.text,
                  phone: phoneController.text,
                  id: phoneController.text,
                  // Optional, change as needed
                  profileImage: phoneController
                      .text, // Optional, change as needed
                );

                // Call the createUserPost API method
                final success = await detailUserService.createUserPost(
                    createProfile);

                if (context.mounted) {
                  if (success) {
                    Navigator.pop(context);
                    await refreshUsers();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("User created successfully")),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Failed to create user")),
                    );
                  }
                }
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }



 void searchPostItem(){
    final TextEditingController searchController = TextEditingController();

 }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       // title: const Text('User List'),

        title:  Container(
         // margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.black54.withOpacity(0.14),
            border: Border.all(width: 1, color: Colors.black87),
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            controller: searchController,
            onChanged: (value) async {
              if (value.isNotEmpty) {
                setState(() => isSearching = true);
                final results = await detailUserService.searchUserDta(value);
                setState(() => searchedUsers = results);
                print('Search : ${searchedUsers}');
              } else {
                setState(() {
                  isSearching = false;
                  searchedUsers = null;
                });
              }
            },
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Search...',
              icon: Icon(Icons.search),
            ),
          ),

        ),

        actions: [
          FloatingActionButton.extended(
            backgroundColor: Colors.blue[300],
            onPressed: (){
              showCreatePostDialog(context);
            },
            label: const Text('Add Post +', style: TextStyle(fontSize: 16),),
            )
        ],
      ),
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

        //  final users = isSearching && searchedUsers != null ? searchedUsers : snapshot.data!.users;


        //  List<UserProfile> users = isSearching && searchedUsers != null ? searchedUsers : (snapshot.data?.users ?? []);


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
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red[300]),
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
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green[300]),
                          onPressed: currentPage < snapshot.data!.totalPages ? nextPage : null, child: const Text('Next')),
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



        /*  return RefreshIndicator(
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
                            rows: users.map((UserProfile user) {
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
                ],
              ),
            ),
          );*/
        },
      ),

    );
  }
}









