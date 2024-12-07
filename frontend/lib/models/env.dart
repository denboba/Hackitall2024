import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppCredentials {
  static String projectId = dotenv.get('PROJECT_ID');
  static String projectEndpoint = dotenv.get('ENDPOINT');
  static String apiKey = dotenv.get('API_KEY');
  static String database = dotenv.get('DATABASE_ID');
  static String userCollection = dotenv.get('USERS_COLLECTION_ID');
  static String userBucket = dotenv.get('USERS_BUCKET_ID');
  static String userProfile = dotenv.get('USERS_PROFILE_ID');
}
