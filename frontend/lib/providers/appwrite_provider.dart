// import 'package:flutter/material.dart';
// import 'package:appwrite/appwrite.dart';
// import 'package:provider/provider.dart';
//
// class AppwriteProvider with ChangeNotifier {
//   final Client _client;
//   late final Storage _storage;
//
//   AppwriteProvider(String endpoint, String projectId, {required Client client})
//       : _client = Client()
//           ..setEndpoint(endpoint)
//           ..setProject(projectId)
//           ..setSelfSigned() {
//     _storage = Storage(_client);
//   }
//
//   Client get client => _client;
//   Storage get storage => _storage;
//   Account get account => Account(_client);
//   Databases get database => Databases(_client);
// }
//
// // Function to create the provider
// ChangeNotifierProvider<AppwriteProvider> createAppwriteProvider(
//     String endpoint, String projectId) {
//   return ChangeNotifierProvider<AppwriteProvider>(
//     create: (context) => AppwriteProvider(endpoint, projectId,
//         client: Provider.of<AppwriteProvider>(context, listen: false).client),
//   );
// }
