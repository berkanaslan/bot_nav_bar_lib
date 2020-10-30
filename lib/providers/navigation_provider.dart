

import 'package:bot_nav_bar_lib/screens/first_screen.dart';
import 'package:bot_nav_bar_lib/screens/fourth_screen.dart';
import 'package:bot_nav_bar_lib/screens/root.dart';
import 'package:bot_nav_bar_lib/screens/screens_of_first/pushed_screen.dart';
import 'package:bot_nav_bar_lib/screens/screens_of_fourth/simple_screen.dart';
import 'package:bot_nav_bar_lib/screens/second_screen.dart';
import 'package:bot_nav_bar_lib/screens/third_screen.dart';
import 'package:bot_nav_bar_lib/widgets/exit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bot_nav_bar_lib/models/screen.dart';


const FIRST_SCREEN = 0;
const SECOND_SCREEN = 1;
const THIRD_SCREEN = 2;
const FOURTH_SCREEN = 3;

class NavigationProvider extends ChangeNotifier {
  /// [NavigationProvider] edinmek için shortcode
  static NavigationProvider of(BuildContext context) =>
      Provider.of<NavigationProvider>(context, listen: false);

  // Açılış sayfası
  int _currentScreenIndex = FIRST_SCREEN;

  int get currentTabIndex => _currentScreenIndex;

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    print('Oluşturulan rota: ${settings.name}');
    switch (settings.name) {
      case PushedScreen.route:
        return MaterialPageRoute(builder: (_) => PushedScreen());
      case SimpleScreen.route:
        return MaterialPageRoute(builder: (_) => SimpleScreen());
      default:
        return MaterialPageRoute(builder: (_) => Root());
    }
  }

  final Map<int, Screen> _screens = {
    FIRST_SCREEN: Screen(
      title: 'First',
      icon: Icons.home,
      child: FirstScreen(),
      initialRoute: FirstScreen.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        print('Oluşturulan rota: ${settings.name}');
        switch (settings.name) {
          case PushedScreen.route:
            return MaterialPageRoute(builder: (_) => PushedScreen());
          default:
            return MaterialPageRoute(builder: (_) => FirstScreen());
        }
      },
      scrollController: ScrollController(),
    ),
    SECOND_SCREEN: Screen(
      title: 'Second',
      icon: Icons.search,
      child: SecondScreen(),
      initialRoute: SecondScreen.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        print('Oluşturulan route: ${settings.name}');
        switch (settings.name) {
          default:
            return MaterialPageRoute(builder: (_) => SecondScreen());
        }
      },
      scrollController: ScrollController(),
    ),
    THIRD_SCREEN: Screen(
      title: 'Third',
      icon: Icons.favorite,
      child: ThirdScreen(),
      initialRoute: ThirdScreen.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        print('Oluşturulan route: ${settings.name}');
        switch (settings.name) {
          default:
            return MaterialPageRoute(builder: (_) => ThirdScreen());
        }
      },
      scrollController: ScrollController(),
    ),
    FOURTH_SCREEN: Screen(
      title: 'Fourth',
      icon: Icons.message,
      child: FourthScreen(),
      initialRoute: FourthScreen.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        print('Oluşturulan route: ${settings.name}');
        switch (settings.name) {
          case SimpleScreen.route:
            return MaterialPageRoute(builder: (_) => SimpleScreen());
          default:
            return MaterialPageRoute(builder: (_) => FourthScreen());
        }
      },
      scrollController: ScrollController(),
    ),
  };

  List<Screen> get screens => _screens.values.toList();

  Screen get currentScreen => _screens[_currentScreenIndex];

  void setTab(int tab) {
    if (tab == currentTabIndex) {
      _scrollToTopOfPage();
    } else {
      _currentScreenIndex = tab;
      notifyListeners();
    }
  }

  /// If currently displayed screen has given [ScrollController] animate it
  /// to the start of scroll view.
  void _scrollToTopOfPage() {
    if (currentScreen.scrollController != null &&
        currentScreen.scrollController.hasClients) {
      currentScreen.scrollController.animateTo(
        0.0,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  /// [WillPopScope] callback'i sağlar
  Future<bool> onWillPop(BuildContext context) async {
    final currentNavigatorState = currentScreen.navigatorState.currentState;

    if (currentNavigatorState.canPop()) {
      currentNavigatorState.pop();
      return false;
    } else {
      if (currentTabIndex != FIRST_SCREEN) {
        setTab(FIRST_SCREEN);
        notifyListeners();
        return false;
      } else {
        return await showDialog(
          context: context,
          builder: (context) => ExitAlertDialog(),
        );
      }
    }
  }
}
