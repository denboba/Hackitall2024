// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../constants/color_constant.dart';
// import '../../constants/constants.dart';
// import '../../models/user.dart';
// import '../../providers/user_provider.dart';
//
// class UserSearchScreen extends StatefulWidget {
//   const UserSearchScreen({super.key});
//
//   @override
//   State<UserSearchScreen> createState() => _UserSearchScreenState();
// }
//
// class _UserSearchScreenState extends State<UserSearchScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   List<User> filteredUsers = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchUsers();
//   }
//
//   Future<void> _fetchUsers() async {
//     try {
//       await Provider.of<UserProvider>(context, listen: false).fetchUsers();
//       setState(() {
//         filteredUsers = Provider.of<UserProvider>(context, listen: false).users;
//       });
//     } catch (e) {
//       print('Error fetching users: $e');
//     }
//   }
//
//   void _filterUsers(String query) {
//     final allUsers = Provider.of<UserProvider>(context, listen: false).users;
//     setState(() {
//       if (query.isEmpty) {
//         filteredUsers = allUsers;
//       } else {
//         filteredUsers = allUsers.where((user) {
//           final name = '${user.firstName} ${user.lastName}'.toLowerCase();
//           final input = query.toLowerCase();
//           return name.contains(input);
//         }).toList();
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Search Users'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Column(
//           children: [
//             // SEARCH BAR
//             TextField(
//               controller: _searchController,
//               onChanged: _filterUsers,
//               decoration: InputDecoration(
//                 prefixIcon: const Icon(Icons.search),
//                 hintText: 'Search for users...',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//
//             // USER LIST
//             Expanded(
//               child: Consumer<UserProvider>(
//                 builder: (context, userProvider, child) {
//                   if (userProvider.users.isEmpty) {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//
//                   return filteredUsers.isNotEmpty
//                       ? ListView.builder(
//                     itemCount: filteredUsers.length,
//                     itemBuilder: (context, index) {
//                       final user = filteredUsers[index];
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 8.0), // Fair distance between list items
//                         child: ListTile(
//                           leading: CircleAvatar(
//                             radius: 30,
//                             backgroundImage:NetworkImage(IMAGES[(() => Random().nextInt(IMAGES.length))()]),
//                           ),
//                           title: Text('${user.firstName} ${user.lastName}'),
//                           subtitle: const Text('Tap to view profile'),
//                           trailing: FollowButton(userId: user.userName), // Follow/Following button
//                           onTap: () {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(content: Text('Tapped on ${user.firstName}')),
//                             );
//                           },
//                         ),
//                       );
//                     },
//                   )
//                       : const Center(
//                     child: Text(
//                       'No users found',
//                       style: TextStyle(fontSize: 18),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class FollowButton extends StatefulWidget {
//   final String userId;
//
//   const FollowButton({Key? key, required this.userId}) : super(key: key);
//
//   @override
//   _FollowButtonState createState() => _FollowButtonState();
// }
//
// class _FollowButtonState extends State<FollowButton> {
//   bool _isFollowing = false;
//
//   void _toggleFollow() {
//     setState(() {
//       _isFollowing = !_isFollowing;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: _toggleFollow,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: _isFollowing ? ColorConstant.lightButtonColor : ColorConstant.buttonColor,
//         minimumSize: const Size(80, 40), // Button size
//       ),
//       child: Text(
//         _isFollowing ? 'Following' : 'Follow',
//         style: const TextStyle(fontSize: 14),
//       ),
//     );
//   }
// }

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/color_constant.dart';
import '../../constants/constants.dart';
import '../../models/user.dart';
import '../../providers/user_provider.dart';
import '../../widgets/UserInfoDialog.dart';

class UserSearchScreen extends StatefulWidget {
  const UserSearchScreen({super.key});

  @override
  State<UserSearchScreen> createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends State<UserSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<User> filteredUsers = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    try {
      await Provider.of<UserProvider>(context, listen: false).fetchUsers();
      setState(() {
        filteredUsers = Provider.of<UserProvider>(context, listen: false).users;
      });
    } catch (e) {
      print('Error fetching users: $e');
    }
  }

  void _filterUsers(String query) {
    final allUsers = Provider.of<UserProvider>(context, listen: false).users;
    setState(() {
      if (query.isEmpty) {
        filteredUsers = allUsers;
      } else {
        filteredUsers = allUsers.where((user) {
          final name = '${user.firstName} ${user.lastName}'.toLowerCase();
          final input = query.toLowerCase();
          return name.contains(input);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Users'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // SEARCH BAR
            TextField(
              controller: _searchController,
              onChanged: _filterUsers,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search for users...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // USER LIST
            Expanded(
              child: Consumer<UserProvider>(
                builder: (context, userProvider, child) {
                  if (userProvider.users.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return filteredUsers.isNotEmpty
                      ? ListView.builder(
                    itemCount: filteredUsers.length,
                    itemBuilder: (context, index) {
                      final user = filteredUsers[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0), // Fair distance between list items
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(IMAGES[(() => Random().nextInt(IMAGES.length))()]),
                          ),
                          title: Text('${user.firstName} ${user.lastName}'),
                          subtitle: const Text('Tap to view profile'),
                          trailing: FollowButton(userId: user.userName), // Follow/Following button
                          onTap: () {
                            // Show the user info dialog when the user taps on a ListTile
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
                        ),
                      );
                    },
                  )
                      : const Center(
                    child: Text(
                      'No users found',
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FollowButton extends StatefulWidget {
  final String userId;

  const FollowButton({Key? key, required this.userId}) : super(key: key);

  @override
  _FollowButtonState createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  bool _isFollowing = false;

  void _toggleFollow() {
    setState(() {
      _isFollowing = !_isFollowing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _toggleFollow,
      style: ElevatedButton.styleFrom(
        backgroundColor: _isFollowing ? ColorConstant.lightButtonColor : ColorConstant.buttonColor,
        minimumSize: const Size(80, 40), // Button size
      ),
      child: Text(
        _isFollowing ? 'Following' : 'Follow',
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}

