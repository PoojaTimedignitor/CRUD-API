   /// USer main screen

/*import 'package:flutter/material.dart';
import 'package:restful_api/screens/user_list_screen.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Pagination Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: UserListScreen(),
    );
  }
}*/





   /// Detail User main screen

 import 'package:flutter/material.dart';
import 'package:restful_api/screens/detail_user_list_screen.dart';
 import 'package:restful_api/screens/user_list_screen.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Pagination Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: DetailUserListScreen(),
    );
  }
}