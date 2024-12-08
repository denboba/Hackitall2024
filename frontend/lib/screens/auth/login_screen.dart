import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/current_user_provider.dart';
import '../home/home_screen.dart';
import 'signup.dart';
import '../../models/string_constants.dart';
import '../../constants/color_constant.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController(); // Username controller
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;
  bool _isLoading = false;
  String? _errorMessage; // Variable to store the error message

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authProvider.initialize().then((_) {
        if (authProvider.loggedInUser != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      });
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 50, 30, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 60.0),
               Center(
              child: Text(
                AppStrings.appName,
                style: TextStyle(
                  fontWeight: FontWeight.bold, // Bold text
                  fontSize: 40, // Increase font size
                  foreground: Paint()
                    ..shader = const LinearGradient(
                      colors: <Color>[Colors.blue, Colors.deepPurple, Colors.pink], // Gradient with more colors
                      begin: Alignment.topLeft, // Gradient direction
                      end: Alignment.bottomRight,
                    ).createShader(const Rect.fromLTWH(0.0, 0.0, 300.0, 70.0)), // Shader area
                  shadows: [
                    Shadow(
                      blurRadius: 8.0, // Soft shadow for more subtle effect
                      color: Colors.black.withOpacity(0.4), // Slightly lighter shadow
                      offset: Offset(5.0, 5.0), // Offset for the shadow
                    ),
                    Shadow(
                      blurRadius: 20.0,
                      color: Colors.white.withOpacity(0.4), // A little white shadow for glow
                      offset: Offset(-5.0, -5.0), // Light glow effect from top-left
                    ),
                  ],
                  letterSpacing: 2.0, // Adjust letter spacing for a clean look
                  fontFamily: 'Roboto', // Use a smooth and readable font (customizable)
                  height: 1.2, // Adjust line height for better vertical spacing
                ),
              ),
              ),
              const SizedBox(height: 40.0),
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 16.0),

              // Username Input Field
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: AppStrings.username, // Updated label to "Username"
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  prefixIcon: const Icon(Icons.person, color: ColorConstant.lightButtonColor),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    //return AppStrings.usernameError; // Username validation error message
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Password Input Field
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: AppStrings.passwordLabel,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  prefixIcon: const Icon(Icons.lock, color: ColorConstant.lightButtonColor),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: ColorConstant.lightButtonColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
                obscureText: _obscureText,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppStrings.passwordError;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24.0),

              // Login Button
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        // Check if username or password fields are empty
                        if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
                          setState(() {
                            _errorMessage = 'Please enter both username and password.';
                            passwordController.clear();
                          });
                          return; // Exit the function early
                        }

                        setState(() {
                          _isLoading = true;
                          _errorMessage = null; // Reset error message
                        });

                        try {
                          await authProvider.login(usernameController.text, passwordController.text);
                          if (authProvider.loggedInUser != null) {
                            print("You are in login screen${authProvider.loggedInUser}");

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const HomeScreen()),
                            );
                          }
                        } catch (e) {
                          setState(() {
                            _errorMessage = 'An unknown error occurred. Please try again.';
                          });
                        } finally {
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstant.buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      ),
                      child: Text(AppStrings.login,
                          style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.white)),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(AppStrings.dontHaveAccount),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SignupScreen()),
                            );
                          },
                          child: Text(AppStrings.signup,
                              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: ColorConstant.buttonColor,
                                fontWeight: FontWeight.w900,
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
