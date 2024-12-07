import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/models/string_constants.dart';
import 'package:frontend/screens/post/upload_image_screen.dart';
import 'package:frontend/screens/users/users.dart';

import 'package:provider/provider.dart';
import '../../constants/constants.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/app_drawer.dart';
import '../users/user_search_screen.dart';
import 'home_page.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userName = authProvider.loggedInUserName;
    final phoneNumber = authProvider.loggedInUserPhone;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            AppStrings.appName,
            style: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
                fontSize: 50),
          ),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), text: "Home"),
              Tab(icon: Icon(Icons.search), text: 'search'),
              Tab(icon: Icon(Icons.person), text: 'connect'),
              Tab(icon: Icon(Icons.add_box_outlined), text: 'post'),
            ],
          ),
        ),
        drawer: AppDrawer(
            username: "@john",
            name: "john DOE",
            bio: bios[(Random().nextInt(bios.length))],
            profileImageUrl: "ajjaj"
        ),
        body: const TabBarView(
          children: [
            Center(child: HomePage()),
            Center(child: UserSearchScreen()),
            Center(child: UsersScreen()),
            Center(child: MediaUploadWidget()),
          ],
        ),
      ),
    );
  }
}




