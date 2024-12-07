// // import 'package:flutter/material.dart';
// // import 'package:frontend/providers/user_provider.dart';
// // import 'package:provider/provider.dart';
// //
// // class UsersScreen extends StatefulWidget {
// //   const UsersScreen({super.key});
// //
// //   @override
// //   _UsersScreenState createState() => _UsersScreenState();
// // }
// //
// // class _UsersScreenState extends State<UsersScreen> {
// //   late Future<void> _fetchUsersFuture;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     // Trigger the fetchUsers method from UserProvider
// //     _fetchUsersFuture =
// //         Provider.of<UserProvider>(context, listen: false).fetchUsers();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Consumer<UserProvider>(
// //         builder: (context, userProvider, child) {
// //           return FutureBuilder(
// //             future: _fetchUsersFuture,
// //             builder: (context, snapshot) {
// //               if (snapshot.connectionState == ConnectionState.waiting) {
// //                 return const Center(child: CircularProgressIndicator());
// //               } else if (snapshot.hasError) {
// //                 return Center(child: Text('Error: ${snapshot.error}'));
// //               } else {
// //                 if (userProvider.users.isEmpty) {
// //                   return const Center(child: Text('No users found.'));
// //                 }
// //                 return ListView.builder(
// //                   scrollDirection: Axis.vertical,
// //                   itemCount: userProvider.users.length,
// //                   itemBuilder: (context, index) {
// //                     final user = userProvider.users[index];
// //                     return ListTile(
// //                       leading: CircleAvatar(
// //                           backgroundImage:
// //                               AssetImage('assets/images/image$index.jpg')),
// //                       title: Text(user.data['first_name'] +
// //                           ' ' +
// //                           user.data['last_name']),
// //                       subtitle: const Text('Follows you'),
// //                       trailing: ElevatedButton(
// //                         onPressed: () {
// //                           print(userProvider.users.length);
// //                         },
// //                         child: const Text('Follow'),
// //                       ),
// //                     );
// //                   },
// //                 );
// //               }
// //             },
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:frontend/providers/user_provider.dart';
// import 'package:provider/provider.dart';
//
// class UsersScreen extends StatefulWidget {
//   const UsersScreen({super.key});
//
//   @override
//   _UsersScreenState createState() => _UsersScreenState();
// }
//
// class _UsersScreenState extends State<UsersScreen> {
//   late Future<void> _fetchUsersFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     // Trigger the fetchUsers method from UserProvider and store the future
//     _fetchUsersFuture = Provider.of<UserProvider>(context, listen: false).fetchUsers();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Consumer<UserProvider>(
//         builder: (context, userProvider, child) {
//           return FutureBuilder(
//             future: _fetchUsersFuture,
//             builder: (context, snapshot) {
//               // Handle different states of the future
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasError) {
//                 return Center(child: Text('Error: ${snapshot.error}'));
//               } else {
//                 // If no users found
//                 if (userProvider.users.isEmpty) {
//                   return const Center(child: Text('No users found.'));
//                 }
//                 return ListView.builder(
//                   itemCount: userProvider.users.length,
//                   itemBuilder: (context, index) {
//                     final user = userProvider.users[index];
//                     return ListTile(
//                       leading: CircleAvatar(
//                         backgroundImage: AssetImage(
//                           'assets/images/image${index % 25}.jpg', // Ensure valid image path
//                         ),
//                       ),
//                       title: Text(
//                           '${user.data['first_name']} ${user.data['last_name']}'),
//                       subtitle: const Text('Follows you'),
//                       trailing: ElevatedButton(
//                         onPressed: () {
//                           // Handle follow button press
//                           print('Follow button pressed for ${user.data['first_name']}');
//                         },
//                         child: const Text('Follow'),
//                       ),
//                     );
//                   },
//                 );
//               }
//             },
//           );
//         },
//       ),
//     );
//   }
// }
//
// extension on Map<String, dynamic> {
//   get data => null;
// }
