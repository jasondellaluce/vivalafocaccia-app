import 'package:app/bloc/search/search_bloc.dart';
import 'package:app/bloc/search_result/search_result_event.dart';
import 'package:app/model/repositories.dart';
import 'package:app/model/models.dart';
import 'package:app/ui/navigation_page.dart';
import 'package:app/ui/pages/search_page.dart';
import 'package:app/ui/pages/keyword_search_result_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_configuration/global_configuration.dart';

import 'package:app/bloc/search_result/keyword_search_result_bloc.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    GlobalConfiguration().loadFromAsset("global_configuration.json").then((_) {
      runApp(VivaLaFocacciaApp(
        recipeRepository: Repositories().ofRecipe(),
        categoryRepository: Repositories().ofCategory(),
      ));
    });
  });
}

class VivaLaFocacciaApp extends StatefulWidget {

  static Color lightPrimary = Color(0xfffcfcff);
  static Color darkPrimary = Colors.black;
  static Color lightAccent = Color(0xff5563ff);
  static Color darkAccent = Color(0xff5563ff);
  static Color lightBG = Color(0xfffcfcff);
  static Color darkBG = Colors.black;
  static Color ratingBG = Colors.yellow[600];
  static ThemeData lightTheme = ThemeData(
      backgroundColor: lightBG,
      primaryColor: lightPrimary,
      accentColor:  lightAccent,
      cursorColor: lightAccent,
      scaffoldBackgroundColor: lightBG,
      appBarTheme: AppBarTheme(
        textTheme: TextTheme(
          headline6: TextStyle(
            color: darkBG,
            fontSize: 18.0,
            fontWeight: FontWeight.w800,
          ),
        ),
      )
  );

  final RecipeRepository recipeRepository;
  final CategoryRepository categoryRepository;

  const VivaLaFocacciaApp({
    Key key,
    @required this.recipeRepository,
    @required this.categoryRepository,
  }) : super(key: key);

  @override
  _VivaLaFocacciaAppState createState() => _VivaLaFocacciaAppState();
}

class _VivaLaFocacciaAppState extends State<VivaLaFocacciaApp> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: VivaLaFocacciaApp.lightPrimary,
      statusBarIconBrightness: Brightness.dark,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: VivaLaFocacciaApp.lightTheme,
      title: GlobalConfiguration().get("appName"),
      home: BlocProvider(
            create: (providerContext) => SearchBloc(
                categoryRepository: Repositories().ofCategory()
            ),
            child: NavigationPage()
      ),
      routes: {

        'search': (context) => BlocProvider(
          create: (providerContext) => SearchBloc(
              categoryRepository: Repositories().ofCategory()
          ),
          child: SearchPage()
        ),

        'keywordSearchResult': (context) => BlocProvider(
          create: (providerContext) => KeywordSearchResultBloc(
              recipeRepository: Repositories().ofRecipe(),
              keyWords: ""
          )..add(FetchResultEvent()),
          child: KeywordSearchResultPage()
        ),
      },
    );
  }
}
