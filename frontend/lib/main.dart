
import 'package:flutter/material.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:frontend/screens/auth/login_screen.dart';
import 'package:frontend/screens/splash_screen/splash.dart'; // Make sure this import is correct
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
        home: Consumer<AuthProvider>(
          builder: (context, authProvider, _) {
            return authProvider.isLoggedIn
                ? const LoginScreen()
                : const OnboardingScreen(); // Make sure OnboardingScreen is imported
          },
        ),
      ),
    );
  }
}


