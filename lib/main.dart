import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:feed_the_cat_app/view/home_screen/home_screen.dart';
import 'package:feed_the_cat_app/services/impl/google_signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const FeedTheCatApp());
}

class FeedTheCatApp extends StatelessWidget {
  const FeedTheCatApp({Key? key}) : super(key: key);

  static const _splashScreenImage = 'assets/images/cat.png';
  static const _splashScreenDuration = 3000;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AnimatedSplashScreen(
          duration: _splashScreenDuration,
          splash: Image.asset(
            _splashScreenImage,
          ),
          nextScreen: const HomeScreen(),
          splashTransition: SplashTransition.sizeTransition,
        ),
      ),
    );
  }
}
