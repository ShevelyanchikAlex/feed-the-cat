import 'package:flutter/material.dart';

class AboutAuthorScreen extends StatelessWidget {
  const AboutAuthorScreen({Key? key}) : super(key: key);
  final String title = 'About Developer';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Row(
              children: [
                const Expanded(
                  child: Padding(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/author.jpg'),
                    ),
                    padding: EdgeInsets.all(15.0),
                  ),
                  flex: 3,
                ),
                Expanded(
                  child: Column(
                    children: const [
                      Padding(
                        child: Text(
                          'Alex Shevelyanchik',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        padding: EdgeInsets.only(top: 25, bottom: 5.0),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          'shevelyanchik01@mail.ru',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  flex: 7,
                ),
              ],
            ),
            flex: 2,
          ),
          Expanded(
            child: Container(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Text(
                      'About App and Developer:',
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Lab №1: Game feed the Cat.\nThe developer is a student of BSUIR (Faculty of Computer Systems and Networks, Department of Information Technology Software, Group: 951008).',
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
            ),
            flex: 7,
          ),
        ],
      ),
    );
  }
}
