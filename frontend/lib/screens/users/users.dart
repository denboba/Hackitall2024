import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../constants/color_constant.dart';
import '../../constants/constants.dart';
import '../../widgets/UserInfoDialog.dart';


class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});
  @override
  UsersScreenState createState() => UsersScreenState();
}

class UsersScreenState extends State<UsersScreen> {
  late Future<void> _fetchUsersFuture;
  late UserProvider _userProvider;
  Map<String, bool> _followStatus = {}; // Map to store follow status for each user

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userProvider = Provider.of<UserProvider>(context, listen: false);
    _fetchUsersFuture = _fetchUsers(); // Ensure fetch happens only once
  }

  Future<void> _fetchUsers() async {
    try {
      await _userProvider.fetchUsers();
      // Initialize follow statuses
      setState(() {
        _followStatus = {
          for (var user in _userProvider.users) user.userName: false
        };
      });
    } catch (e) {
      print('Error fetching users: $e');
    }
  }

  void _toggleFollow(String userName) {
    setState(() {
      _followStatus[userName] = !(_followStatus[userName] ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Tribe'),
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          return FutureBuilder(
            future: _fetchUsersFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (userProvider.users.isEmpty) {
                return const Center(child: Text('No users found.'));
              } else {
                return ListView.builder(
                  itemCount: userProvider.users.length,
                  itemBuilder: (context, index) {
                    final user = userProvider.users[index];
                    final isFollowing = _followStatus[user.userName] ?? false;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                      child:GestureDetector(
                        child:  Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16.0),
                            leading:CircleAvatar(
                            backgroundImage: NetworkImage(IMAGES[(() => Random().nextInt(IMAGES.length))()]),
                            radius: 30,

                          ),
                            title: Text('${user.firstName} ${user.lastName}'),
                            trailing: ElevatedButton(
                              onPressed: () {
                                _toggleFollow(user.userName);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isFollowing ? ColorConstant.lightButtonColor : ColorConstant.buttonColor,
                              ),
                              child: Text(
                                isFollowing ? 'Following' : 'Follow',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      onTap: () {
                        // Show user information dialog when list item is tapped
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return UserInfoDialog(
                              username: user.userName,
                              name: '${user.firstName} ${user.lastName}',
                              bio: bios[(() => Random().nextInt(bios.length))()],
                              profileImageUrl: IMAGES[(() => Random().nextInt(IMAGES.length))()],
                            );
                          },
                        );
                      },
                      )
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
