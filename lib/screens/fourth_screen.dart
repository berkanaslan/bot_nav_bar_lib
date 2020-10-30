import 'package:bot_nav_bar_lib/screens/screens_of_fourth/simple_screen.dart';
import 'package:flutter/material.dart';

class FourthScreen extends StatelessWidget {
  static const route = '/extra';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Extra Screen')),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Push with bottom navigation visible
            Navigator.of(
              context,
              rootNavigator: true,
            ).pushNamed(SimpleScreen.route);
          },
          child: Text('Go to Simple Page'),
        ),
      ),
    );
  }
}
