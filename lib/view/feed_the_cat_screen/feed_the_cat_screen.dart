import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import '../../dao/db_helper.dart';
import '../../models/progress.dart';
import '../../models/record.dart';
import '../../services/impl/google_signin.dart';
import '../home_screen/custom_drawer.dart';

class FeedTheCatScreen extends StatefulWidget {
  const FeedTheCatScreen({Key? key}) : super(key: key);

  @override
  _FeedTheCatScreenState createState() => _FeedTheCatScreenState();
}

class _FeedTheCatScreenState extends State<FeedTheCatScreen>
    with SingleTickerProviderStateMixin {
  final String title = 'Feed the Cat';
  final DBHelper _dbHelper = DBHelper.instance;

  int _counter = 0;
  late AnimationController _controller;
  int _currentColorIndex = 0;
  final user = FirebaseAuth.instance.currentUser!;

  final List _colors = [
    Colors.red,
    Colors.green,
    Colors.black38,
    Colors.deepPurple,
  ];

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              Share.share('Feed my Cat: $_counter');
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Provider.of<GoogleSignInService>(context, listen: false).logout();
            },
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: (_counter % 15 == 0 && _counter != 0)
                  ? Lottie.asset(
                      'assets/lotties/hearts.json',
                      height: 200.0,
                      controller: _controller,
                      onLoaded: (LottieComposition composition) {
                        _controller
                          ..duration = composition.duration
                          ..forward();
                      },
                    )
                  : const SizedBox(
                      height: 150.0,
                    ),
              flex: 2,
            ),
            Expanded(
              child: AnimatedBuilder(
                animation: _controller.view,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _controller.value * 2 * pi,
                    child: child,
                  );
                },
                child: const Image(
                  image: AssetImage('assets/images/cat.png'),
                ),
              ),
              flex: 4,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    child: Text(
                      'Satiety: $_counter',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    padding: const EdgeInsets.all(3.0),
                  ),
                  Padding(
                    child: SizedBox(
                      width: 100,
                      height: 50,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.redAccent),
                        ),
                        onPressed: _incrementCounter,
                        child: const Text(
                          'Feed',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.all(3.0),
                  ),
                  Padding(
                    child: SizedBox(
                      width: 100, // <-- Your width
                      height: 50,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.redAccent),
                        ),
                        onPressed: () async {
                          _saveResult(
                              userName: user.displayName!, score: _counter);
                          Fluttertoast.showToast(
                              msg: "Result was saved",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.white,
                              textColor: Colors.black,
                              fontSize: 16.0);
                        },
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.all(3.0),
                  ),
                ],
              ),
              flex: 3,
            ),
            Expanded(
              child: Padding(
                child: _guitarHero(),
                padding: const EdgeInsets.all(3.0),
              ),
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }

  Container _guitarHero() {
    return Container(
      child: Column(
        children: [
          Center(
            child: _guitarHeroButton(
              color: _colors[_currentColorIndex],
              isColorPicker: true,
              currentColorIndex: 0,
            ),
          ),
          Center(
            child: Row(
              children: [
                _guitarHeroButton(
                  color: _colors[0],
                  isColorPicker: false,
                  currentColorIndex: 0,
                ),
                _guitarHeroButton(
                  color: _colors[1],
                  isColorPicker: false,
                  currentColorIndex: 1,
                ),
                _guitarHeroButton(
                  color: _colors[2],
                  isColorPicker: false,
                  currentColorIndex: 2,
                ),
                _guitarHeroButton(
                  color: _colors[3],
                  isColorPicker: false,
                  currentColorIndex: 3,
                ),
              ],
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(15.0),
      ),
    );
  }

  Padding _guitarHeroButton(
      {required color, required isColorPicker, required currentColorIndex}) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 15,
        left: 15,
      ),
      child: ElevatedButton(
        onPressed: () =>
            isColorPicker ? {} : _checkSelectedColor(currentColorIndex),
        child: const SizedBox(),
        style: ElevatedButton.styleFrom(
          primary: color,
        ),
      ),
    );
  }

  void _checkSelectedColor(int tappedButtonIndex) {
    if (_currentColorIndex == tappedButtonIndex) {
      setState(() {
        _currentColorIndex = Random().nextInt(4);
        _incrementCounter();
      });
    }
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      if (_counter % 15 == 0 && _counter != 0) {
        if (_controller.status == AnimationStatus.completed) {
          _controller.reset();
        }
        _controller.forward();
        // print(FutureBuilder(builder: builder)_dbHelper.getUserInfoList().asStream().length);
      }
      if (_counter == 50) {
        _saveProgress(
            userName: user.displayName!, nameOfProgress: 'First Progress');
        Fluttertoast.showToast(
            msg: "Progress 50 has been received!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0);
      } else if (_counter == 100) {
        _saveProgress(
            userName: user.displayName!, nameOfProgress: 'Second Progress');
        Fluttertoast.showToast(
            msg: "Progress 100 has been received!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0);
      }
    });
  }

  Future<void> _saveResult({required userName, required score}) async {
    await _dbHelper.insertOrUpdateRecordByUserName(Record(
      userName: userName,
      dateTime: DateTime.now().toString(),
      score: score,
    ));
  }

  Future<void> _saveProgress(
      {required userName, required nameOfProgress}) async {
    await _dbHelper.insertProgress(Progress(
      userName: userName,
      name: nameOfProgress,
    ));
  }
}
