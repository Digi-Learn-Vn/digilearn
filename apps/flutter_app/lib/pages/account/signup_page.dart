import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_app/core/services/auth.dart';

class SignupPage extends StatefulWidget {
  final ValueNotifier<bool> isDarkTheme;
  const SignupPage({Key? key, required this.isDarkTheme}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _profilenameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repasswordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  bool _isPasswordVisible = false;
  String? error;

  void handleSignup() async {
    final email = _emailController.text;
    final profilename = _usernameController.text;
    final password = _passwordController.text;
    final repassword = _repasswordController.text;
    final username = _usernameController.text;

    if (email.isEmpty ||
        password.isEmpty ||
        username.isEmpty ||
        repassword.isEmpty ||
        profilename.isEmpty) {
      setState(() {
        error = 'All fields are required';
      });
      return;
    }

    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email)) {
      setState(() {
        error = 'Invalid email format';
      });
      return;
    }

    if (password != repassword) {
      setState(() {
        error = 'Passwords do not match';
      });
      return;
    }

    if (password.length < 8) {
      setState(() {
        error = 'Password must be at least 8 characters long';
      });
      return;
    }

    final err =
        await register(username, profilename, email, password, repassword);
    print('Signup result: $err'); // Log the result
    if (err == null) {
      setState(() {
        error = null;
      });
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Success'),
          content: const Text('Account created successfully!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      setState(() {
        error = err['message'] as String?;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor:
              widget.isDarkTheme.value ? Colors.white : Colors.black,
          elevation: 1,
          title: Row(
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    GoRouter.of(context).go('/');
                  },
                  child: Image.asset(
                    widget.isDarkTheme.value
                        ? 'assets/logo_dark.png'
                        : 'assets/logo_light.png',
                    height: 40,
                  ),
                ),
              ),
            ],
          )),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Create an account',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _profilenameController,
                      decoration: const InputDecoration(
                        labelText: 'Profile Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _repasswordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Re-enter Password',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    if (error != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          error!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // Forgot password action
                        },
                        child: const Text('Forgot ?'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: handleSignup,
                      child: const Text('Create account'),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      // icon: Image.asset('assets/google_icon.png', height: 24),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        side: const BorderSide(color: Colors.grey),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        // Handle Google sign-up
                      },
                      label: const Text('Continue with Google'),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already Have An Account ?'),
                        TextButton(
                          onPressed: () {
                            GoRouter.of(context).go('/account/signin');
                          },
                          child: const Text('Log In'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: widget.isDarkTheme.value ? Colors.white : Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLink("Privacy Policy", "https://yourdomain.com/privacy", 12),
            const SizedBox(width: 16),
            _buildLink("Terms of Service", "https://yourdomain.com/terms", 12),
            const SizedBox(width: 16),
            Text(
              "© 2025 Your Company",
              style: TextStyle(
                fontSize: 12,
                color: widget.isDarkTheme.value ? Colors.black : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLink(String label, String url, double fontSize) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          }
        },
        child: Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            color: widget.isDarkTheme.value ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}
