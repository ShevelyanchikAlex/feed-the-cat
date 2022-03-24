import 'package:feed_the_cat_app/view/feed_the_cat_screen/feed_the_cat_screen.dart';
import 'package:feed_the_cat_app/view/signup_screen/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'custom_drawer.dart';
import '../logged_in_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: const CustomDrawer(),
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return const FeedTheCatScreen();
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          } else {
            return const SignUpScreen();
          }
        },
      ),
    );
  }
}
