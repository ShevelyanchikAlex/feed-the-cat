import 'package:feed_the_cat_app/view/progress_screen/progress_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../about_author_screen/about_author_screen.dart';
import '../description_game/game_description_screen.dart';
import '../results_screen/results_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.blue, Colors.greenAccent],
              ),
            ),
            accountName: Text(
              user.displayName!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            accountEmail: Text(
              user.email!,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              foregroundColor: Colors.white,
              child: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(user.photoURL!),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.developer_mode),
            title: const Text(
              'About Developer',
            ),
            onTap: () async {
              final createdSuggestion = await Navigator.push(
                context,
                _routePage(const AboutAuthorScreen()),
              );
            },
          ),
          const Divider(
            height: 3,
            color: Colors.black38,
            indent: 15,
            endIndent: 15.0,
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text(
              'Game Description',
            ),
            onTap: () async {
              final createdSuggestion = await Navigator.push(
                context,
                _routePage(const GameDescriptionScreen()),
              );
            },
          ),
          const Divider(
            height: 3,
            color: Colors.black38,
            indent: 15,
            endIndent: 15.0,
          ),
          ListTile(
            leading: const Icon(Icons.analytics_outlined),
            title: const Text(
              'Results',
            ),
            onTap: () async {
              final createdSuggestion = await Navigator.push(
                context,
                _routePage(const ResultScreen()),
              );
            },
          ),
          const Divider(
            height: 3,
            color: Colors.black38,
            indent: 15,
            endIndent: 15.0,
          ),
          ListTile(
            leading: const Icon(Icons.show_chart),
            title: const Text(
              'Progress',
            ),
            onTap: () async {
              final createdSuggestion = await Navigator.push(
                context,
                _routePage(const ProgressScreen()),
              );
            },
          ),
          const Divider(
            height: 3,
            color: Colors.black38,
            indent: 15,
            endIndent: 15.0,
          ),
        ],
      ),
    );
  }

  Route _routePage(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (c, a1, a2) => screen,
      transitionsBuilder: (
        context,
        animation,
        secondaryAnimation,
        child,
      ) {
        return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(animation),
            child: child);
      },
    );
  }
}
