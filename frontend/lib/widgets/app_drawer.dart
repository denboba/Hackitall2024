import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/constants/color_constant.dart';

import '../constants/constants.dart';
import '../screens/auth/login_screen.dart';

class AppDrawer extends StatelessWidget {
  final String username;
  final String name;
  final String bio;
  final String profileImageUrl;

  const AppDrawer({
    super.key,
    required this.username,
    required this.name,
    required this.bio,
    required this.profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          // User Account Header (Instagram-like)
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: ColorConstant.backgroundColor,
            ),
            accountName: Text(
              name,
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            accountEmail: Text(
              '@$username',
              style: const TextStyle(
                color: Colors.black45,
                fontSize: 14.0,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              radius: 50.0,  // Increased the radius for a larger avatar
              backgroundImage: NetworkImage(IMAGES[(() => Random().nextInt(IMAGES.length))()]),
              backgroundColor: Colors.transparent,
            ),
            otherAccountsPictures: [
              IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: ColorConstant.buttonColor,
                ),
                onPressed: () {
                  // Navigate to edit profile
                },
              ),
            ],
          ),

          // Bio Section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bio:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  bio,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),

          // Highlighted Stories Section (Instagram-like)
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
            child: SizedBox(
              height: 100.0,  // Increased height for more space
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5, // Replace with dynamic count
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: CircleAvatar(
                      radius: 40.0,  // Increased the radius for a larger avatar
                      backgroundImage: NetworkImage(profileImageUrl),
                      backgroundColor: Colors.transparent,
                    ),
                  );
                },
              ),
            ),
          ),

          const Divider(color: Colors.grey),

          // Drawer options like in Instagram
          Expanded(
            child: ListView(
              children: <Widget>[
                // Your Posts Section
                ListTile(
                  leading: const Icon(Icons.grid_on, color: Colors.black),
                  title: const Text('Your Posts'),
                  onTap: () {
                    //TODO: Navigate to user's posts
                  },
                ),
                // Saved Section
                ListTile(
                  leading: const Icon(Icons.bookmark, color: Colors.black),
                  title: const Text('Saved'),
                  onTap: () {
                    //TODO: Navigate to saved posts
                  },
                ),
                // Explore Section
                ListTile(
                  leading: const Icon(Icons.explore, color: Colors.black),
                  title: const Text('Explore'),
                  onTap: () {
                    // Navigate to explore
                  },
                ),
                // Activity Section
                ListTile(
                  leading: const Icon(Icons.notifications, color: Colors.black),
                  title: const Text('Activity'),
                  onTap: () {
                    // Navigate to activity
                  },
                ),
                // Settings Section
                ListTile(
                  leading: const Icon(Icons.settings, color: Colors.black),
                  title: const Text('Settings'),
                  onTap: () {
                    // Handle Settings
                  },
                ),
                // Logout Section
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.black),
                  title: const Text('Logout'),
                  onTap: () {
                    // return to login screen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
