
import 'package:flutter/material.dart';
import 'package:frontend/constants/color_constant.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/screens/auth/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:country_picker/country_picker.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController nationalityCountryController = TextEditingController();
  final TextEditingController nationalityCityController = TextEditingController();
  final TextEditingController residenceCountryController = TextEditingController();
  final TextEditingController residenceCityController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // Country picker related variables
  Country? selectedNationalityCountry;
  Country? selectedResidenceCountry;

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    ageController.dispose();
    nationalityCountryController.dispose();
    nationalityCityController.dispose();
    residenceCountryController.dispose();
    residenceCityController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await Provider.of<AuthProvider>(context, listen: false).register(
        email: emailController.text,
        password: passwordController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        username: userNameController.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration successful! Please log in.')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed: $error')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(40, 20, 40, 30),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'Create Account',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: ColorConstant.buttonColor, fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField(userNameController, 'Username', Icons.person, iconColor: ColorConstant.buttonColor),
              _buildTextField(firstNameController, 'First Name', Icons.person, iconColor: ColorConstant.buttonColor),
              _buildTextField(lastNameController, 'Last Name', Icons.person, iconColor: ColorConstant.buttonColor),
              _buildTextField(emailController, 'Email', Icons.email, iconColor: ColorConstant.buttonColor),
              _buildTextField(passwordController, 'Password', Icons.lock, isPassword: true, iconColor: ColorConstant.buttonColor),
              _buildTextField(confirmPasswordController, 'Confirm Password', Icons.lock, isPassword: true, iconColor: ColorConstant.buttonColor),
              _buildTextField(phoneController, 'Phone', Icons.phone, iconColor: ColorConstant.buttonColor),
              _buildCountryPicker('Nationality Country', nationalityCountryController, true),
              _buildTextField(nationalityCityController, 'Nationality City', Icons.location_city, iconColor: ColorConstant.buttonColor),
              _buildCountryPicker('Residence Country', residenceCountryController, false),
              _buildTextField(residenceCityController, 'Residence City', Icons.location_city, iconColor: ColorConstant.buttonColor),
              const SizedBox(height: 20),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                onPressed: _register,
                child: const Text('Sign Up'),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                    },
                    child: const Text('Log In'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to build text fields
  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool isPassword = false, Color iconColor = ColorConstant.buttonColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword ? _obscurePassword : false,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: iconColor),
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off, color: iconColor),
            onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
          )
              : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Please enter $label';
          return null;
        },
      ),
    );
  }

  // Method to add country picker
  Widget _buildCountryPicker(String label, TextEditingController controller, bool isNationality) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () => _showCountryPicker(isNationality),
        child: InputDecorator(
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.flag, color: ColorConstant.buttonColor),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
            labelText: label,
          ),
          child: Text(
            isNationality
                ? (selectedNationalityCountry?.name ?? 'Select Country')
                : (selectedResidenceCountry?.name ?? 'Select Country'),
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }

  // Method to show country picker
  void _showCountryPicker(bool isNationality) {
    showCountryPicker(
      context: context,
      onSelect: (Country country) {
        setState(() {
          if (isNationality) {
            selectedNationalityCountry = country;
            nationalityCountryController.text = country.name;
          } else {
            selectedResidenceCountry = country;
            residenceCountryController.text = country.name;
          }
        });
      },
    );
  }
}
