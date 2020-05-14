
import 'package:app/navigator_bottom_navbar/navigator_bottom_navbar.dart';
import 'package:app/pages/pages.dart';
import 'package:app/repositories/repositories.dart';
import 'package:app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:provider/provider.dart';

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
    var repositoryFactory = RepositoryFactory();
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        //scaffoldBackgroundColor: HexColor("#fefcf8"),
        primaryColor: Colors.orange,
        // accentColor: HexColor("#FFB500")
      ),
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
        providers: [
          Provider<LocalizationService>(
              create: (context) => LocalizationService(
                  stringGetter: (s) => GlobalConfiguration().get(s))),
          Provider<BlogContentService>(
              create: (context) => BlogContentService(
                  categoryRepository: repositoryFactory.forCategory(),
                  postRepository: repositoryFactory.forPost(),
                  recipeRepository: repositoryFactory.forRecipe())),
          ChangeNotifierProvider<AuthenticationService>(
              create: (context) => AuthenticationService(
                  userRepository: repositoryFactory.forUser())),
        ],
        child: NavigatorBottomNavbar(
          routePageMap: {
            "/" : HomePage(),
            "/home" : HomePage(),
            "/personal" : LoginPage(),
          },
          bottomTabs: [
            NavigatorBottomTab(
              routeName: "/home",
              title: "Home",
              icon: Icon(Icons.home)
            ),
            NavigatorBottomTab(
              routeName: "/personal",
              title: "Personal",
              icon: Icon(Icons.person)
            )
          ],
        ),
      )
    );
  }
}
