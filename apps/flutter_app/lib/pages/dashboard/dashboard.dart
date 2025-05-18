import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_app/core/services/auth.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Map<String, dynamic>? userProfile;
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    setState(() {
      isLoading = true;
      error = null;
    });
    try {
      final profile = await getUserProfile();
      if (profile != null) {
        setState(() {
          userProfile = profile;
          isLoading = false;
        });
      } else {
        setState(() {
          error = 'Failed to load user profile.';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Error: ' + e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await logout();
              GoRouter.of(context).go('/account/signin');
            },
          ),
        ],
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : error != null
                ? Text(error!, style: const TextStyle(color: Colors.red))
                : userProfile != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Welcome!',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 16),
                          Text(
                              'Username: ${userProfile!['username'] ?? 'N/A'}'),
                          Text('Email: ${userProfile!['email'] ?? 'N/A'}'),
                          if (userProfile!['name'] != null)
                            Text('Name: ${userProfile!['name']}'),
                        ],
                      )
                    : const Text('No user data.'),
      ),
    );
  }
}
