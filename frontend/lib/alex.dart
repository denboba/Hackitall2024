import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  final url = Uri.parse('http://10.200.21.182:5000/users');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // If the server returns a successful response
      var data = json.decode(response.body);
      print(data);  // Print the decoded JSON data
    } else {
      print('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}