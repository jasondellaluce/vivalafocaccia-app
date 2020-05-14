import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';

import 'vivalafocaccia_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    GlobalConfiguration().loadFromAsset("global_configuration.json").then((_) {
      runApp(VivaLaFocacciaApp());
    });
  });
}

