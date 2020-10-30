import 'package:bot_nav_bar_lib/providers/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            onGenerateRoute: NavigationProvider.of(context).onGenerateRoute,
          );
        },
      ),
    );
  }
}
