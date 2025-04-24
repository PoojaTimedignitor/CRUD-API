/*
import 'package:flutter/material.dart';
import '../model/profile_model.dart';
import '../service/detail_user_service.dart';
import 'package:http/http.dart' as http;

class UserDetailPage extends StatelessWidget {
  final UserProfile userProfile;
  final DetailUserService _detailUserService = DetailUserService();

  UserDetailPage({super.key, required this.userProfile});



  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: const Text("Are you sure you want to delete this user?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              Navigator.pop(context); // Close dialog
              final success = await _detailUserService.deleteUser(userProfile.id);

              if (context.mounted) {
                if (success) {
                  Navigator.pop(context); // Go back to the list screen
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("User deleted successfully")),

                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Failed to delete user")),
                  );
                }
              }
            },
            child: const Text("Delete", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Detail')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(userProfile.profileImage),
                  ),
                ),
                const SizedBox(height: 20),
                Text('ID: ${userProfile.id}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 12),
                Text('First Name: ${userProfile.firstName}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 12),
                Text('Last Name: ${userProfile.lastName}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 12),
                Text('Email: ${userProfile.email}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 12),
                Text('Phone: ${userProfile.phone}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300]),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Back'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red[300]),
                      onPressed: () => _confirmDelete(context),
                      child: const Text('Delete', style: TextStyle(color: Colors.black87)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/


///
///
///
/*import 'package:flutter/material.dart';
import '../model/profile_model.dart';
import '../service/detail_user_service.dart';

class UserDetailPage extends StatefulWidget {
  final UserProfile userProfile;
  final VoidCallback onDelete;
  UserDetailPage({super.key, required this.userProfile, required this.onDelete});

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {

  final DetailUserService detailUserService = DetailUserService();

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: const Text("Are you sure you want to delete this user?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              Navigator.pop(context); // Close dialog
              final success = await detailUserService.deleteUser(widget.userProfile.id);

              if (context.mounted) {
                if (success) {
                  widget.onDelete(); // <-- Trigger refresh
                  Navigator.pop(context); // Go back to the list screen
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("User deleted successfully")),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Failed to delete user")),
                  );
                }
              }
            },
            child: const Text("Delete", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Detail')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(widget.userProfile.profileImage),
                  ),
                ),
                const SizedBox(height: 20),
                Text('ID: ${widget.userProfile.id}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 12),
                Text('First Name: ${widget.userProfile.firstName}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 12),
                Text('Last Name: ${widget.userProfile.lastName}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 12),
                Text('Email: ${widget.userProfile.email}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 12),
                Text('Phone: ${widget.userProfile.phone}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300]),
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Back'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red[300]),
                      onPressed: () => _confirmDelete(context),
                      child: const Text('Delete', style: TextStyle(color: Colors.black87)),
                    ),


                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}*/



import 'package:flutter/material.dart';
import '../model/profile_model.dart';
import '../service/detail_user_service.dart';

class UserDetailPage extends StatefulWidget {
  final UserProfile userProfile;
  final VoidCallback onDelete;

  UserDetailPage({
    super.key,
    required this.userProfile,
    required this.onDelete,
  });

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  final DetailUserService detailUserService = DetailUserService();
  late UserProfile currentUser;




  @override
  void initState() {
    super.initState();
    currentUser = widget.userProfile; // Set initial user
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: const Text("Are you sure you want to delete this user?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              Navigator.pop(context);
              final success = await detailUserService.deleteUser(currentUser.id);

              if (context.mounted) {
                if (success) {
                  widget.onDelete();
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("User deleted successfully")),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Failed to delete user")),
                  );
                }
              }
            },
            child: const Text("Delete", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }



  void _showEditDialog(BuildContext context) {
    final _firstNameController = TextEditingController(text: currentUser.firstName);
    final _lastNameController = TextEditingController(text: currentUser.lastName);
    final _emailController = TextEditingController(text: currentUser.email);
    final _phoneController = TextEditingController(text: currentUser.phone);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit User"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: _firstNameController, decoration: const InputDecoration(labelText: "First Name")),
              TextField(controller: _lastNameController, decoration: const InputDecoration(labelText: "Last Name")),
              TextField(controller: _emailController, decoration: const InputDecoration(labelText: "Email")),
              TextField(controller: _phoneController, decoration: const InputDecoration(labelText: "Phone")),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              final updatedUser = UserProfile(
                id: currentUser.id,
                firstName: _firstNameController.text,
                lastName: _lastNameController.text,
                email: _emailController.text,
                phone: _phoneController.text,
                profileImage: currentUser.profileImage,
              );

              final success = await detailUserService.updateUser(updatedUser);

            //  final success = await updateUser(updatedUser);

              if (context.mounted) {
                if (success) {
                  setState(() => currentUser = updatedUser);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("User updated successfully")),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Failed to update user")),
                  );
                }
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Detail')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(currentUser.profileImage),
                  ),
                ),
                const SizedBox(height: 20),
                Text('ID: ${currentUser.id}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 12),
                Text('First Name: ${currentUser.firstName}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 12),
                Text('Last Name: ${currentUser.lastName}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 12),
                Text('Email: ${currentUser.email}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 12),
                Text('Phone: ${currentUser.phone}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300]),
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Back'),
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red[300]),
                      onPressed: () => _confirmDelete(context),
                      child: const Text('Delete', style: TextStyle(color: Colors.white)),
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[300]),
                      onPressed: () => _showEditDialog(context),
                      child: const Text('Edit', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

