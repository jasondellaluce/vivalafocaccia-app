import 'package:app/model/repositories.dart';
import 'package:app/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app/bloc/search/search_bloc.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(VivaLaFocacciaApp(
      recipeRepository: ModelRepositoryFactory.instance.getRecipeRepository(),
      categoryRepository: ModelRepositoryFactory.instance.getCategoryRepository(),
    ));
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
      title: "VivaLaFocaccia",
      home: BlocProvider(
        create: (context) =>
            SearchBloc(
              categoryRepository: ModelRepositoryFactory.instance.getCategoryRepository()
            ),
        child: SearchPage(),
      ),
    );
  }
}
