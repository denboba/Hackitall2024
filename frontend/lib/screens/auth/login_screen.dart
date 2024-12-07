import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;
  bool _isLoading = false;
  String? _errorMessage; // Variable to store the error message
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
   print("You are in login screen${authProvider.loggedInUser}");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authProvider.initialize().then((_) {
        // TODO: UNCOMMENT THIS
        //if (authProvider.loggedInUser != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
      //  }
      });
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 60.0),
              const Center(
                child: CircleAvatar(
                  radius: 60.0,
                  child: Icon(
                    Icons.person,
                    size: 60.0,
                    color: ColorConstant.lightButtonColor,
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
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: AppStrings.email,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  prefixIcon: const Icon(Icons.email,
                      color: ColorConstant.lightButtonColor),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppStrings.emialError;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: AppStrings.passwordLabel,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  prefixIcon: const Icon(Icons.lock,
                      color: ColorConstant.lightButtonColor),
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
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        // Check if email or password fields are empty
                        if (emailController.text.isEmpty ||
                            passwordController.text.isEmpty) {
                          setState(() {
                            _errorMessage =
                                'Please enter both email and password.';
                            passwordController.clear();
                          });
                          return; // Exit the function early
                        }

                        setState(() {
                          _isLoading = true;
                          _errorMessage = null; // Reset error message
                        });

                        try {
                          await authProvider.login(
                              emailController.text, passwordController.text);
                          if (authProvider.loggedInUser != null) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()),
                            );
                          }
                        } on UserNotFoundException {
                          setState(() {
                            _errorMessage =
                                'User not found. Please check your email or sign up.';
                          });
                        } on InvalidCredentialsException {
                          setState(() {
                            _errorMessage =
                                'Invalid credentials. Please try again.';
                          });
                        } catch (e) {
                          setState(() {
                            _errorMessage =
                                'An unknown error occurred. Please try again.';
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12.0),
                      ),
                      child: Text(AppStrings.login,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(color: Colors.white)),
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
                              MaterialPageRoute(
                                  builder: (context) => const SignupScreen()),
                            );
                          },
                          child: Text(AppStrings.signup,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                      color: ColorConstant.buttonColor,
                                      fontWeight: FontWeight.w900)),
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
