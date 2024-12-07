
import 'package:flutter/material.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'screens/splash_screen/splash.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  String apiUrl = dotenv.env['API_URL']!; // link name in .env file
  runApp(MyApp(apiUrl: apiUrl));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.apiUrl});
  final String apiUrl;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider(apiUrl: apiUrl)),
        ChangeNotifierProvider(create: (_) => UserProvider(apiUrl: apiUrl)),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
       home: const OnboardingScreen(), // Show Onboarding Screen first
      //  home: const LoginScreen()
      ),
    );
  }
}