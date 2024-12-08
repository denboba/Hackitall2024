// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class AuthProvider with ChangeNotifier {
//   String? _authToken;
//   Map<String, dynamic>? _loggedInUser;
//   Map<String, dynamic>? get loggedInUser => _loggedInUser;
//   String get loggedInUserName => _loggedInUser?['username'] ?? 'Guest User';
//   String get loggedInUserEmail => _loggedInUser?['email'] ?? 'Email not found';
//   String get loggedInUserPhone => _loggedInUser?['phone'] ?? 'Phone not found';
//
//   final String apiUrl;
//
//   AuthProvider({required this.apiUrl});
//
//   get client => null;
//   Future<void> initialize() async {
//     // Try to get user data if token is already stored (e.g. in SharedPreferences)
//     if (_authToken != null) {
//       await fetchUserProfile();
//     } else {
//       _loggedInUser = null;
//       notifyListeners();
//     }
//   }
//
//   Future<void> login(String username, String password) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$apiUrl/login'),
//         body: {'username': username, 'password': password},
//       );
//
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         _authToken = data['access'];
//         await fetchUserProfile();
//         notifyListeners();
//       } else {
//         throw InvalidCredentialsException();
//       }
//     } catch (e) {
//       print('Login error: $e');
//       throw InvalidCredentialsException();
//     }
//   }
//
//   Future<void> register(
//       {required String email,
//         required String password,
//         required String firstName,
//         required String lastName}) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$apiUrl/register'),
//         body: {
//           'email': email,
//           'password': password,
//           'first_name': firstName,
//           'last_name': lastName,
//         },
//       );
//
//       if (response.statusCode == 201) {
//         final data = json.decode(response.body);
//         _authToken = data['access'];
//         await fetchUserProfile();
//         notifyListeners();
//       } else {
//         throw UserAlreadyExistsException();
//       }
//     } catch (e) {
//       print('Register error: $e');
//       throw UserAlreadyExistsException();
//     }
//   }
//
//   Future<void> fetchUserProfile() async {
//     try {
//       final response = await http.get(
//         Uri.parse('$apiUrl/login'),
//       );
//
//       if (response.statusCode == 200) {
//         _loggedInUser = json.decode(response.body);
//         notifyListeners();
//       } else {
//         throw UserNotFoundException();
//       }
//     } catch (e) {
//       print('Fetch user profile error: $e');
//     }
//   }
//
//   Future<void> logout() async {
//     try {
//       _authToken = null;
//       _loggedInUser = null;
//       notifyListeners();
//     } catch (e) {
//       print('Logout error: $e');
//     }
//   }
//
//   Future<void> updateProfile({
//     required String name,
//     required String email,
//     required String phone,
//     required String password,
//   }) async {
//     try {
//       final response = await http.put(
//         Uri.parse('$apiUrl/user/'),
//         headers: {'Authorization': 'Bearer $_authToken'},
//         body: {
//           'name': name,
//           'email': email,
//           'phone': phone,
//           'password': password,
//         },
//       );
//
//       if (response.statusCode == 200) {
//         await fetchUserProfile();
//         notifyListeners();
//       } else {
//         throw Exception('Profile update failed');
//       }
//     } catch (e) {
//       print('Update profile error: $e');
//     }
//   }
//
//   // Example of using the database API for storing user data:
//   Future<void> createDocument({
//     required String firstName,
//     required String lastName,
//     required String email,
//     required int age,
//     required String phone,
//     required String dateOfBirth,
//     required String gender,
//   }) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$apiUrl/user/create_document'),
//         headers: {'Authorization': 'Bearer $_authToken'},
//         body: {
//           'first_name': firstName,
//           'last_name': lastName,
//           'email': email,
//           'age': age.toString(),
//           'phone': phone,
//           'date_of_birth': dateOfBirth,
//           'gender': gender,
//         },
//       );
//
//       if (response.statusCode == 201) {
//         notifyListeners();
//       } else {
//         print('Create document error: ${response.body}');
//       }
//     } catch (e) {
//       print('Create document error: $e');
//     }
//   }
// }
//
// class UserAlreadyExistsException implements Exception {
//   @override
//   String toString() => 'User with this email already exists.';
// }
//
// class UserNotFoundException implements Exception {
//   @override
//   String toString() => 'User not found. Please check your credentials.';
// }
//
// class InvalidCredentialsException implements Exception {
//   @override
//   String toString() => 'Invalid credentials. Please try again.';
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider with ChangeNotifier {
  Map<String, dynamic>? _loggedInUser;
  Map<String, dynamic>? get loggedInUser => _loggedInUser;
  String get loggedInUserName => _loggedInUser?['username'] ?? 'Guest User';
  String get loggedInUserEmail => _loggedInUser?['email'] ?? 'Email not found';
  String get loggedInUserPhone => _loggedInUser?['phone'] ?? 'Phone not found';

  final String apiUrl;

  AuthProvider({required this.apiUrl});

  Future<void> initialize() async {
    _loggedInUser = null;
    notifyListeners();
  }

  Future<void> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/login'),
        body: {'username': username, 'password': password},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> userData = json.decode(response.body);
        _loggedInUser = userData;
        notifyListeners();
      } else {
        throw InvalidCredentialsException();
      }
    } catch (e) {
      print('Login error: $e');
      throw InvalidCredentialsException();
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

// class UserNotFoundException implements Exception {
//   @override
//   String toString() => 'User not found. Please check your credentials.';
// }

class InvalidCredentialsException implements Exception {
  @override
  String toString() => 'Invalid credentials. Please try again.';
}
