export 'src/navigation_bottom_tab.dart';

import 'src/navigation_bottom_tab.dart';
import 'package:flutter/material.dart';

class NavigatorBottomNavbar extends StatefulWidget {
  final List<NavigatorBottomTab> bottomTabs;
  final Map<String, Widget> routePageMap;
  final bool maintainStateOnNavigation;
  final Color backgroundColor;
  final Color selectedTabColor;
  final Color unselectedTabColor;

  const NavigatorBottomNavbar(
      {Key key,
      @required this.bottomTabs,
      @required this.routePageMap,
      this.maintainStateOnNavigation = false,
      this.backgroundColor,
      this.selectedTabColor,
      this.unselectedTabColor})
      : super(key: key);

  @override
  _NavigatorBottomNavbarState createState() => _NavigatorBottomNavbarState();
}

class _NavigatorBottomNavbarState extends State<NavigatorBottomNavbar> {
  final navigatorKey = GlobalKey<NavigatorState>();
  int selectedIndex;

  @override
  void initState() {
    selectedIndex = 0;
    super.initState();
  }

  void _selectIndex(int index) {
    setState(() {
      selectedIndex = index;
      navigatorKey.currentState.pushNamed(widget.bottomTabs[index].routeName);
    });
  }

  WidgetBuilder _parseRoute(String routeName) {
    if (!widget.routePageMap.containsKey(routeName))
      throw Exception("Unknown Navigation Route: $routeName");
    return (context) => widget.routePageMap[routeName];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (navigatorKey.currentState.canPop()) {
            navigatorKey.currentState.pop();
            return false;
          }
          return true;
        },
        child: Navigator(
          key: navigatorKey,
          initialRoute: "/",
          onGenerateRoute: (settings) {
            var indexOfName = widget.bottomTabs
                .indexWhere((tab) => tab.routeName == settings.name);
            if (indexOfName >= 0) {
              setState(() {
                selectedIndex = indexOfName;
              });
            }
            return MaterialPageRoute(
                builder: _parseRoute(settings.name),
                maintainState: widget.maintainStateOnNavigation,
                settings: settings);
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: widget.bottomTabs.map((tab) {
          return BottomNavigationBarItem(
            icon: tab.icon,
            title: Text(tab.title),
          );
        }).toList(),
        currentIndex: selectedIndex,
        selectedItemColor:
            widget.selectedTabColor ?? Theme.of(context).primaryColor,
        unselectedItemColor: widget.unselectedTabColor ??
            Theme.of(context).unselectedWidgetColor,
        backgroundColor:
            widget.backgroundColor ?? Theme.of(context).bottomAppBarColor,
        onTap: _selectIndex,
      ),
    );
  }
}
