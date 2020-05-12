import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';
import 'pages/recipe_page.dart';
import 'core/core.dart';
import 'repositories/repositories.dart';

class NavigationApp extends StatefulWidget {
  @override
  _VivaLaFocacciaAppState createState() => _VivaLaFocacciaAppState();
}

class _VivaLaFocacciaAppState extends State<NavigationApp> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "VivaLaFocaccia",
      theme: ThemeData.dark().copyWith(
          primaryColor: Colors.deepOrange,
          accentColor: Colors.yellowAccent),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.amber,
        accentColor: Colors.redAccent,
      ),
      debugShowCheckedModeBanner: false,
      home: _BottomBarWidget(),
    );
  }
}

class _BottomBarWidget extends StatefulWidget {
  final navigationTabRoutes = ["/home", "/home", "/home"];

  final routeMap = {
    '/': HomePage(),
    '/home': HomePage(),
    '/recipeOverview': RecipePage(),
  };

  final sharedLocalization = Localization((s) => GlobalConfiguration().get(s));
  final sharedRepositoryFactory = RepositoryFactory();

  _BottomBarWidget({Key key}) : super(key: key);

  @override
  _BottomBarWidgetState createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<_BottomBarWidget> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  int selectedIndex;

  @override
  void initState() {
    selectedIndex = 0;
    super.initState();
  }

  void _selectIndex(int index) {
    setState(() {
      selectedIndex = index;
      _navigatorKey.currentState.pushNamed(widget.navigationTabRoutes[index]);
    });
  }

  WidgetBuilder _parseRoute(String routeName) {
    if (!widget.routeMap.containsKey(routeName))
      throw Exception("Unknown Navigation Route!");

    // TODO: Implement route-specific providers here

    return (context) =>
        _applySharedProviders(context, widget.routeMap[routeName]);
  }

  Widget _applySharedProviders(BuildContext context, Widget child) {
    return Provider<Localization>(
        create: (BuildContext context) => widget.sharedLocalization,
        child: Provider<RepositoryFactory>(
          create: (BuildContext context) => widget.sharedRepositoryFactory,
          child: child,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (_navigatorKey.currentState.canPop()) {
            _navigatorKey.currentState.pop();
            return false;
          }
          return true;
        },
        child: Navigator(
          key: _navigatorKey,
          initialRoute: "/",
          onGenerateRoute: (settings) {
            var indexOfName = widget.navigationTabRoutes.indexOf(settings.name);
            if (indexOfName >= 0) {
              setState(() {
                selectedIndex = indexOfName;
              });
            }
            return MaterialPageRoute(
              builder: _parseRoute(settings.name),
              maintainState: false,
              settings: settings);
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Ricerca'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Personale'),
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Theme.of(context).accentColor,
        onTap: _selectIndex,
      ),
    );
  }
}
