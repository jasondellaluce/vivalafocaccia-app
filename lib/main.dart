import 'package:app/recipe_overview_page.dart';
import 'package:app/recipe_page.dart';
import 'package:app/widgets/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:provider/provider.dart';

import 'core/localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
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
        primaryColor: HexColor("#F5500A"),
        accentColor: HexColor("#FFB500")
      ),
      debugShowCheckedModeBanner: false,
      home: Provider<Localization>(
        create: (BuildContext context) => Localization((s) => GlobalConfiguration().get(s)),
        child: RecipePage(),
      )
    );
  }
}
