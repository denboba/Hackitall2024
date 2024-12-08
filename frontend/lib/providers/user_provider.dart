import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frontend/models/user.dart';  // Import the User model

class UserProvider with ChangeNotifier {
  List<User> _users = [];  // Change to hold User objects
  String? apiUrl;

  UserProvider({required this.apiUrl});
  List<User> get users => _users;

  Future<void> fetchUsers() async {
    _users = [];
    try {
      int limit = 25;
      int offset = 0;

      bool hasMoreUsers = true;
      while (hasMoreUsers) {
        final url = Uri.parse('$apiUrl/users/filter?field=nationality_country&value=Ethiopia');
        final response = await http.get(url);
        print(response.body);


        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          List<User> newUsers = (data["users"] as List)
              .map((userData) => User.fromMap(userData))  // Map each result to a User object
              .toList();
          _users.addAll(newUsers);
          print(_users);

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
      String link = "$apiUrl/users/$userId";
      final response = await http.get(
        Uri.parse(link),
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
