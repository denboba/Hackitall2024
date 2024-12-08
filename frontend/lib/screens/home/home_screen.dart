import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/models/string_constants.dart';
import 'package:frontend/screens/users/users.dart';

import 'package:provider/provider.dart';
import '../../constants/constants.dart';
import '../../providers/auth_provider.dart';
import '../../providers/current_user_provider.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/Explore.dart';

import '../post/post_screen.dart';
import '../users/user_search_screen.dart';
import 'home_page.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userName = authProvider.loggedInUserName;
    final phoneNumber = authProvider.loggedInUserPhone;
    final email = authProvider.loggedInUserEmail;
    final first = authProvider.loggedInUserFirstName;
    final last = authProvider.loggedInUserLastName;
    final userProfileProvider = Provider.of<UserProfileProvider>(context);
    print("this is the user profile provider $userProfileProvider");




    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            AppStrings.appName,
            style: TextStyle(
              fontWeight: FontWeight.bold, // Bold text
              fontSize: 40, // Increase font size
              foreground: Paint()
                ..shader = const LinearGradient(
                  colors: <Color>[Colors.blue, Colors.deepPurple, Colors.pink], // Gradient with more colors
                  begin: Alignment.topLeft, // Gradient direction
                  end: Alignment.bottomRight,
                ).createShader(const Rect.fromLTWH(0.0, 0.0, 300.0, 70.0)), // Shader area
              shadows: [
                Shadow(
                  blurRadius: 8.0, // Soft shadow for more subtle effect
                  color: Colors.black.withOpacity(0.4), // Slightly lighter shadow
                  offset: Offset(5.0, 5.0), // Offset for the shadow
                ),
                Shadow(
                  blurRadius: 20.0,
                  color: Colors.white.withOpacity(0.4), // A little white shadow for glow
                  offset: Offset(-5.0, -5.0), // Light glow effect from top-left
                ),
              ],
              letterSpacing: 2.0, // Adjust letter spacing for a clean look
              fontFamily: 'Roboto', // Use a smooth and readable font (customizable)
              height: 1.2, // Adjust line height for better vertical spacing
            ),
          ),


        centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), text: "Home"),
              Tab(icon: Icon(Icons.search), text: 'Search'),
              Tab(icon: Icon(Icons.person), text: 'Connect'),
              Tab(icon: Icon(Icons.add_box_outlined), text: 'Post'),
              Tab(icon: Icon(Icons.explore), text: 'Explore'),
            ],
          ),
        ),
        drawer: AppDrawer(
            username: userName,
            name: "$first $last",
            bio: bios[(Random().nextInt(bios.length))],
            profileImageUrl: "_____"
        ),
        body:  TabBarView(
          children: [
            const Center(child: HomePage()),
            const Center(child: UserSearchScreen()),
            const Center(child: UsersScreen()),
            const Center(child: PostUploadForm()),
                Center(child: ExploreTheCountry()),
          ],
        ),
      ),
    );
  }
}




