import 'dart:convert';

import 'package:flutter/material.dart';

class UserProfileProvider extends ChangeNotifier {
  Map<String, dynamic>? _userData;
  String? _errorMessage;
  bool _isLoading = false;

  Map<String, dynamic>? get userData => _userData;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  get http => null;

  Future<void> fetchUserProfile(String username) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final String apiUrl = 'http://10.200.21.182:5000/users/$username'; // Replace with the actual API URL

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        _userData = json.decode(response.body);
      } else {
        _errorMessage = 'Failed to load user data';
      }
    } catch (e) {
      _errorMessage = 'Failed to fetch user data: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
