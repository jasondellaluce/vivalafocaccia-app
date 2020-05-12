import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:provider/provider.dart';

import 'core/localization.dart';
import "pages/recipe_page.dart";
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    GlobalConfiguration().loadFromAsset("global_configuration.json").then((_) {
      runApp(VivaLaFocacciaApp());
    });
  });
}

class VivaLaFocacciaApp extends StatefulWidget {
  @override
  _VivaLaFocacciaAppState createState() => _VivaLaFocacciaAppState();
}

class _VivaLaFocacciaAppState extends State<VivaLaFocacciaApp> {
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
        theme: ThemeData.dark().copyWith(
          //scaffoldBackgroundColor: HexColor("#fefcf8"),
          primaryColor: Colors.orange,
          // accentColor: HexColor("#FFB500")
        ),
        debugShowCheckedModeBanner: false,
        home: Provider<Localization>(
          create: (BuildContext context) =>
              Localization((s) => GlobalConfiguration().get(s)),
          child: LoginPage(),
        ));
  }
}
