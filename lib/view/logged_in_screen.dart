import 'package:feed_the_cat_app/services/impl/google_signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoggedInScreen extends StatelessWidget {
  const LoggedInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Log In'),
        actions: [
          TextButton(
            onPressed: () {
              final provider =
                  Provider.of<GoogleSignInService>(context, listen: false);
              provider.logout();
            },
            child: const Text(
              'Log Out',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const Text('Profile'),
            const SizedBox(height: 32),
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(user.photoURL!),
            ),
            const SizedBox(height: 8),
            Text(
              'Name: ' + user.displayName!,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Email: ' + user.email!,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
