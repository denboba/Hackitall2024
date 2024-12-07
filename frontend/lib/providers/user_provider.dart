// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:frontend/models/env.dart';
//
// class UserProvider with ChangeNotifier {
//   String? _authToken;
//   List<Map<String, dynamic>> _users = [];
//   String? apiUrl;
//
//   UserProvider({required this.apiUrl});
//
//   List<Map<String, dynamic>> get users => _users;
//
//   Future<void> fetchUsers() async {
//     _users = []; // Clear the previous user list before fetching new data
//     try {
//       int limit = 25;
//       int offset = 0;
//
//       bool hasMoreUsers = true;
//       while (hasMoreUsers) {
//         final response = await http.get(
//           Uri.parse('$apiUrl/api/users/'),
//           headers: {'Authorization': 'Bearer $_authToken'},
//           // Add query parameters to implement pagination
//           // For example, to fetch 25 users at a time, you can use the following query parameters
//         );
//
//         if (response.statusCode == 200) {
//           final data = json.decode(response.body);
//           List<Map<String, dynamic>> newUsers = List<Map<String, dynamic>>.from(data['results']);
//           _users.addAll(newUsers);
//
//           if (newUsers.length < limit) {
//             hasMoreUsers = false;  // No more users to fetch
//           } else {
//             offset += limit; // Increase the offset for the next page of results
//           }
//         } else {
//           throw Exception('Failed to load users');
//         }
//       }
//
//       notifyListeners();  // Notify listeners when the user list is updated
//     } catch (e) {
//       print('Error fetching users: $e');
//     }
//   }
//
//   void clearUsers() {
//     _users = [];  // Clear the current user list
//     notifyListeners();  // Notify listeners about the change
//   }
//
//   // Optionally, you could implement a method to fetch users based on a specific criterion
//   Future<void> fetchUserById(String userId) async {
//     try {
//       final response = await http.get(
//         Uri.parse('$apiUrl/api/users/$userId/'),
//         headers: {'Authorization': 'Bearer $_authToken'},
//       );
//
//       if (response.statusCode == 200) {
//         final user = json.decode(response.body);
//         // Handle the fetched user data as needed (store, update state, etc.)
//       } else {
//         throw Exception('Failed to fetch user by ID');
//       }
//     } catch (e) {
//       print('Error fetching user by ID: $e');
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frontend/models/env.dart';
import 'package:frontend/models/user.dart';  // Import the User model

class UserProvider with ChangeNotifier {
  String? _authToken;
  List<User> _users = [];  // Change to hold User objects
  String? apiUrl;

  UserProvider({required this.apiUrl});


  List<User> get users => _users;  // Return User objects instead of Map<String, dynamic>

  Future<void> fetchUsers() async {
    _users = []; // Clear the previous user list before fetching new data
    try {
      int limit = 25;
      int offset = 0;

      bool hasMoreUsers = true;
      while (hasMoreUsers) {
       // https://randomuser.me/api/?results=10\
        String link = "$apiUrl/api/?results=20";
        print(link);
        final response = await http.get(
          Uri.parse(link),
          headers: {'Authorization': 'Bearer $_authToken'},
        );


        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          List<User> newUsers = (data['results'] as List)
              .map((userData) => User.fromMap(userData))  // Map each result to a User object
              .toList();
          _users.addAll(newUsers);

          if (newUsers.length < limit) {
            hasMoreUsers = false;  // No more users to fetch
          } else {
            offset += limit; // Increase the offset for the next page of results
          }
        } else {
          print('Error: Failed to load users, status code: ${response.statusCode}');
          throw Exception('Failed to load users');
        }
      }

      notifyListeners();  // Notify listeners when the user list is updated
    } catch (e) {
      print('Error fetching users: $e');
    }
  }

  void clearUsers() {
    _users = [];  // Clear the current user list
    notifyListeners();  // Notify listeners about the change
  }

  // Optionally, you could implement a method to fetch users based on a specific criterion
  Future<void> fetchUserById(String userId) async {
    try {
      String link = "$apiUrl/api/?results=20";
      final response = await http.get(
        Uri.parse(link),
        headers: {'Authorization': 'Bearer $_authToken'},
      );

      if (response.statusCode == 200) {
        final user = json.decode(response.body);
        // Handle the fetched user data as needed (store, update state, etc.)
      } else {
        throw Exception('Failed to fetch user by ID');
      }
    } catch (e) {
      print('Error fetching user by ID: $e');
    }
  }
}
