import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:note_app/core/db/db_helper.dart';
import 'package:note_app/theme/light.dart';

import 'ui/pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return GetMaterialApp(
      title: "Flutter Note App",
      debugShowCheckedModeBanner: false,
      theme: LightTheme().light(),
      home: HomePage(),
    );
  }
}
