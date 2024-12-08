import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider with ChangeNotifier {
  Map<String, dynamic>? _loggedInUser;
  Map<String, dynamic>? get loggedInUser => _loggedInUser;
  String get loggedInUserName => _loggedInUser?['username'] ?? '';
  String get loggedInUserEmail => _loggedInUser?['email'] ?? '';
  String get loggedInUserPhone => _loggedInUser?['phone'] ?? '';
  String get loggedInUserUsername => _loggedInUser?['username'] ?? 'John';
  String get loggedInUserFirstName => _loggedInUser?['first_name'] ?? 'Doe';
  String get loggedInUserLastName => _loggedInUser?['last_name'] ?? '';
  String get loggedInUserDateOfBirth => _loggedInUser?['date_of_birth'] ?? '';

  final String apiUrl;

  AuthProvider({required this.apiUrl});

  get isLoggedIn => _loggedInUser != null;

  Future<void> initialize() async {
    _loggedInUser = null;
    notifyListeners();
  }

  Future<void> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/login'),
        headers: {
          'Content-Type': 'application/json', // Set the content type to JSON
        },
        body: json.encode({
          'username': username,
          'password': password,
        }), // Convert the body to JSON
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> userData = json.decode(response.body);
        final _user = await http.get(Uri.parse('$apiUrl/users/$username'));
        _loggedInUser = json.decode(_user.body);
        notifyListeners();
      } else {
        throw Exception('Login failed');
      }
    } catch (e) {
      print('Login error: $e');
    }
  }


  Future<void> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String username,
  }) async {
    try {
      // Prepare the data to be sent as JSON
      final Map<String, dynamic> requestBody = {
        'email': email,
        'password': password,
        'first_name': firstName,
        'last_name': lastName,
        'username':username,
      };

      // Send the POST request with the JSON body
      final response = await http.post(
        Uri.parse('$apiUrl/register'),
        headers: {
          'Content-Type': 'application/json', // Set the header for JSON
        },
        body: json.encode(requestBody), // Convert the request body to JSON
      );

      print(response.body);

      if (response.statusCode == 201) {
        final Map<String, dynamic> userData = json.decode(response.body);
        _loggedInUser = userData;
        notifyListeners();
      } else {
        print('Register error: ${response.statusCode}');
        print(response.body);
      }
    } catch (e) {
      print('Register error: $e');
      throw UserAlreadyExistsException();
    }
  }


  Future<void> fetchUserProfile() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/user/profile'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> userData = json.decode(response.body);
        _loggedInUser = userData;
        notifyListeners();
      } else {
       // throw UserNotFoundException();
        print(response.body);
      }
    } catch (e) {
      print('Fetch user profile error: $e');
    }
  }

  Future<void> logout() async {
    try {
      _loggedInUser = null;
      notifyListeners();
    } catch (e) {
      print('Logout error: $e');
    }
  }

  Future<void> updateProfile({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$apiUrl/user/'),
        body: {
          'name': name,
          'email': email,
          'phone': phone,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        await fetchUserProfile();
        notifyListeners();
      } else {
        throw Exception('Profile update failed');
      }
    } catch (e) {
      print('Update profile error: $e');
    }
  }

  Future<void> createDocument({
    required String firstName,
    required String lastName,
    required String email,
    required int age,
    required String phone,
    required String dateOfBirth,
    required String gender,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/user/create_document'),
        body: {
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'age': age.toString(),
          'phone': phone,
          'date_of_birth': dateOfBirth,
          'gender': gender,
        },
      );

      if (response.statusCode == 201) {
        notifyListeners();
      } else {
        print('Create document error: ${response.body}');
      }
    } catch (e) {
      print('Create document error: $e');
    }
  }
}

class UserAlreadyExistsException implements Exception {
  @override
  String toString() => 'User with this email already exists.';
}
