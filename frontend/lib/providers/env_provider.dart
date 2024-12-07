import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// class EnvProvider with ChangeNotifier {
//   late final String projectId;
//   late final String projectEndpoint;
//   late final String apiKey;
//   late final String databaseId;
//   late final String collectionId;
//   late final String bucketId;
//
//   EnvProvider() {
//     // Initialize the environment variables from .env file
//     projectId = dotenv.env['APPWRITE_PROJECT_ID']!;
//     projectEndpoint = dotenv.env['APPWRITE_ENDPOINT']!;
//     apiKey = dotenv.env['APPWRITE_API_KEY']!;
//     databaseId = dotenv.env['USERS_DATABASE_ID']!;
//     collectionId = dotenv.env['USERS_COLLECTION_ID']!;
//     bucketId = dotenv.env['APPWRITE_BUCKET_ID']!;
//   }
//
//   // Getters for the environment variables
//   String get getProjectId => projectId;
//   String get getProjectEndpoint => projectEndpoint;
//   String get getApiKey => apiKey;
//   String get getDatabaseId => databaseId;
//   String get getCollectionId => collectionId;
//   String get getBucketId => bucketId;
//
//   getInstance() {
//     return this;
//   }
// }
