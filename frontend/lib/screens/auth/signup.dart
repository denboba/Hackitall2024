import 'package:flutter/material.dart';
import 'package:frontend/constants/color_constant.dart';
import 'package:frontend/models/string_constants.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/screens/auth/login_screen.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:appwrite/appwrite.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  late DateTime? birthDate;
  late DateFormat formatter;
  late String selectedGender;
  String? errorMessage; // Variable to store error message
  bool _isLoading = false; // Track if the registration is in progress
  bool _isSuccess = false; // Track if registration was successful
  int age = 0;
  String?
      phoneNumberWithCountryCode; // Store the phone number with country code

  bool _obscurePassword = true; // Track password visibility
  bool _obscureConfirmPassword = true; // Track confirm password visibility

  @override
  void initState() {
    super.initState();
    formatter = DateFormat(AppStrings.dateFormat);
    birthDate = null;
    selectedGender = AppStrings.male;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    ageController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    setState(() {
      _isLoading = true;
      errorMessage = null;
      _isSuccess = false;
    });

    if (_formKey.currentState!.validate()) {
      if (passwordController.text != confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(AppErrors.passwordNotMatch),
          ),
        );
        setState(() {
          _isLoading = false;
        });
        passwordController.clear();
        confirmPasswordController.clear();
        return;
      }

      try {
        await Provider.of<AuthProvider>(context, listen: false).register(
          email: emailController.text,
          password: passwordController.text,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
        );

        await Provider.of<AuthProvider>(context, listen: false).createDocument(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          age: age,
          phone: phoneNumberWithCountryCode!,
          dateOfBirth: ageController.text,
          gender: selectedGender,
        );
        setState(() {
          _isLoading = false;
          errorMessage = null;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } on UserAlreadyExistsException {
        setState(() {
          errorMessage =
              'A user with this email already exists. Please use a different email.';
        });
      } catch (e) {
        if (e is AppwriteException) {
          setState(() {
            errorMessage = e.message; // Display AppwriteException message
          });
        } else {
          setState(() {
            errorMessage =
                AppErrors.unknownError; // Display unknown error message
          });
        }
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Text(
                    AppStrings.createAccount,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20.0),
                if (errorMessage != null)
                  Text(
                    errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                if (_isSuccess)
                  const Text(
                    'Registration successful! Please log in.',
                    style: TextStyle(color: Colors.green),
                  ),
                const SizedBox(height: 20.0),
                const Text(AppStrings.name),
                TwinTextField(
                  controller1: firstNameController,
                  controller2: lastNameController,
                  label1: AppStrings.firstName,
                  label2: AppStrings.lastName,
                  icon1: Icons.person,
                  icon2: Icons.person,
                ),
                const SizedBox(height: 16.0),
                const Text(AppStrings.email),
                Center(
                  child: SingleTextField(
                    controller: emailController,
                    label: AppStrings.email,
                    icon: Icons.email,
                    isEmail: true,
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(AppStrings.password),
                TwinTextField(
                  controller1: passwordController,
                  controller2: confirmPasswordController,
                  label1: AppStrings.password,
                  label2: AppStrings.confirmPassword,
                  icon1: Icons.lock,
                  icon2: Icons.lock,
                  isPassword: true,
                  obscurePassword: _obscurePassword,
                  obscureConfirmPassword: _obscureConfirmPassword,
                  togglePasswordVisibility: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  toggleConfirmPasswordVisibility: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                const Text(AppStrings.phone),
                Center(
                  child: IntlPhoneField(
                    decoration: InputDecoration(
                      labelText: AppStrings.phone,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      prefixIcon: const Icon(Icons.phone,
                          color: ColorConstant.lightButtonColor),
                    ),
                    controller: phoneController,
                    initialCountryCode: AppStrings.intialCountryCode,
                    onChanged: (phone) {
                      setState(() {
                        phoneNumberWithCountryCode = phone.completeNumber;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.number.isEmpty) {
                        return AppErrors.pleaseEnterPhone;
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(AppStrings.selectDateOfBirth),
                const SizedBox(height: 8.0),
                GestureDetector(
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null && pickedDate != birthDate) {
                      setState(() {
                        birthDate = pickedDate;
                        ageController.text = formatter.format(birthDate!);
                        age = (DateTime.now().year - birthDate!.year).toInt();
                      });
                    }
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: ageController,
                      decoration: InputDecoration(
                        labelText: AppStrings.dateOfBirth,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        prefixIcon: const Icon(Icons.calendar_today,
                            color: ColorConstant.lightButtonColor),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppErrors.pleaseEnterDateOfBirth;
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(AppStrings.gender),
                const SizedBox(height: 8.0),
                DropdownButtonFormField<String>(
                  value: selectedGender,
                  decoration: InputDecoration(
                    labelText: AppStrings.gender,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: AppStrings.male,
                      child: Row(
                        children: [
                          Icon(Icons.boy,
                              color: ColorConstant.lightButtonColor),
                          SizedBox(width: 8),
                          Text(AppStrings.male),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: AppStrings.female,
                      child: Row(
                        children: [
                          Icon(Icons.girl,
                              color: ColorConstant.lightButtonColor),
                          SizedBox(width: 8),
                          Text(AppStrings.female),
                        ],
                      ),
                    ),
                  ],
                  onChanged: (String? value) {
                    setState(() {
                      selectedGender = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "${AppErrors.pleaseEnter} ${AppStrings.gender}";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: _register,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstant.buttonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12.0),
                        ),
                        child: Text(AppStrings.signup,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(color: Colors.white)),
                      ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(AppStrings.haveAccount),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      },
                      child: Text(AppStrings.login,
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
          ),
        ),
      ),
    );
  }
}

class TwinTextField extends StatelessWidget {
  const TwinTextField({
    super.key,
    required this.controller1,
    required this.controller2,
    required this.label1,
    required this.label2,
    this.icon1,
    this.icon2,
    this.isPassword = false,
    this.obscurePassword,
    this.obscureConfirmPassword,
    this.togglePasswordVisibility,
    this.toggleConfirmPasswordVisibility,
  });

  final TextEditingController controller1;
  final TextEditingController controller2;
  final String label1;
  final String label2;
  final IconData? icon1;
  final IconData? icon2;
  final bool isPassword;
  final bool? obscurePassword;
  final bool? obscureConfirmPassword;
  final VoidCallback? togglePasswordVisibility;
  final VoidCallback? toggleConfirmPasswordVisibility;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SingleTextField(
            controller: controller1,
            label: label1,
            icon: icon1,
            isPassword: isPassword,
            obscureText: obscurePassword,
            toggleVisibility: togglePasswordVisibility,
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: SingleTextField(
            controller: controller2,
            label: label2,
            icon: icon2,
            isPassword: isPassword,
            obscureText: obscureConfirmPassword,
            toggleVisibility: toggleConfirmPasswordVisibility,
          ),
        ),
      ],
    );
  }
}

class SingleTextField extends StatelessWidget {
  const SingleTextField({
    super.key,
    required this.controller,
    required this.label,
    this.icon,
    this.isPassword = false,
    this.isEmail = false,
    this.obscureText,
    this.toggleVisibility,
  });

  final TextEditingController controller;
  final String label;
  final IconData? icon;
  final bool isPassword;
  final bool isEmail;
  final bool? obscureText;
  final VoidCallback? toggleVisibility;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword ? obscureText ?? true : false,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        prefixIcon: icon != null
            ? Icon(
                icon,
                color: ColorConstant.lightButtonColor,
              )
            : null,
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                    obscureText! ? Icons.visibility : Icons.visibility_off),
                color: ColorConstant.lightButtonColor,
                onPressed: toggleVisibility,
              )
            : null,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "${AppErrors.pleaseEnter} $label";
        }
        if (isEmail && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return AppErrors.invalidEmail;
        }
        return null;
      },
    );
  }
}
