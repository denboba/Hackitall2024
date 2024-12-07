// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
//
// class DjangoProvider with ChangeNotifier {
//   final String baseUrl;
//
//   DjangoProvider({required this.baseUrl});
//
//   // Example function to login
//   Future<Map<String, dynamic>> loginUser(String email, String password) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/api/login/'),  // Replace with your Django API endpoint
//         body: jsonEncode({
//           'email': email,
//           'password': password,
//         }),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//       );
//
//       if (response.statusCode == 200) {
//         return jsonDecode(response.body); // Return user data or token on success
//       } else {
//         throw Exception('Failed to login');
//       }
//     } catch (e) {
//       throw Exception('Error logging in: $e');
//     }
//   }
//
//   // Example function to fetch user data
//   Future<Map<String, dynamic>> fetchUserData(String token) async {
//     try {
//       final response = await http.get(
//         Uri.parse('$baseUrl/api/user/'),  // Replace with your Django API endpoint
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       );
//
//       if (response.statusCode == 200) {
//         return jsonDecode(response.body);  // Return user data
//       } else {
//         throw Exception('Failed to fetch user data');
//       }
//     } catch (e) {
//       throw Exception('Error fetching user data: $e');
//     }
//   }
//
//   // Example function to upload a profile picture
//   Future<String> uploadProfilePicture(String token, String filePath) async {
//     try {
//       var request = http.MultipartRequest(
//         'POST',
//         Uri.parse('$baseUrl/api/upload/'),  // Replace with your Django API endpoint
//       );
//
//       request.headers['Authorization'] = 'Bearer $token';
//       request.files.add(await http.MultipartFile.fromPath('file', filePath));
//
//       var response = await request.send();
//
//       if (response.statusCode == 200) {
//         final responseData = await http.Response.fromStream(response);
//         final data = jsonDecode(responseData.body);
//         return data['fileUrl'];  // Return the file URL from the response
//       } else {
//         throw Exception('Failed to upload profile picture');
//       }
//     } catch (e) {
//       throw Exception('Error uploading profile picture: $e');
//     }
//   }
// }
