import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vox_box/core/theme_data/colour_scheme.dart';
import 'package:vox_box/modules/login/infra/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService(); // Instance of AuthService.
  bool _isLoading = false; // Boolean to track loading state.
  String? _errorMessage; // String to store error messages.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green, // Set background color.
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Hero(
                      tag: 'logo',
                      child: Text('Vox Box',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge), // Display app name.
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                        top: 48,
                        right: 16,
                        left: 16,
                        bottom: 48), // Padding for the container.
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0), // Rounded corners.
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Login to continue',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                color: secondaryText, // Text color from theme.
                              ),
                        ),
                        const SizedBox(height: 40), // Space between elements.
                        _isLoading
                            ? SizedBox(
                                width: 40,
                                height: 40,
                                child:
                                    const CircularProgressIndicator()) // Loading indicator.
                            : ElevatedButton.icon(
                                icon: Image.asset(
                                  'assets/images/Google_logo.png',
                                  height: 30.0,
                                  width: 30.0,
                                ),
                                label: Text('Continue with Google',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontSize: 20,
                                          color: Colors.black
                                              .withOpacity(0.6), // Text style.
                                        )),
                                onPressed: () async {
                                  setState(() {
                                    _isLoading = true; // Set loading to true.
                                    _errorMessage =
                                        null; // Clear previous error message.
                                  });
                                  User? user = await _authService
                                      .signInWithGoogle(); // Attempt Google sign-in using AuthService.
                                  if (user != null) {
                                    Navigator.of(context).pushReplacementNamed(
                                        '/home'); // Navigate to chat screen on success.
                                  } else {
                                    setState(() {
                                      _isLoading =
                                          false; // Reset loading state on failure.
                                    });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  backgroundColor: Colors.white,
                                  minimumSize: const Size(
                                      double.infinity, 50), // Button size.
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // Button shape.
                                  ),
                                ),
                              ),
                        if (_errorMessage != null)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _errorMessage!,
                              style: const TextStyle(
                                  color: Colors.red), // Display error message.
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
