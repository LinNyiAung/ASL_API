import 'package:asl_api/alphabet.dart';
import 'package:asl_api/alphabet/a.dart';
import 'package:asl_api/alphabet/b.dart';
import 'package:asl_api/alphabet/c.dart';
import 'package:asl_api/alphabet/d.dart';
import 'package:asl_api/asl.dart';
import 'package:asl_api/course.dart';
import 'package:asl_api/home.dart';
import 'package:asl_api/library.dart';
import 'package:asl_api/setting.dart';
import 'package:asl_api/word.dart';
import 'package:asl_api/word/different.dart';
import 'package:asl_api/word/hello.dart';
import 'package:asl_api/word/love.dart';
import 'package:asl_api/word/thankyou.dart';
import 'package:asl_api/word/think.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (context) => SplashScreen(),
      '/home': (context) => HomePage(),
      '/asl': (context) => ASLSignLanguageTranslator(camera: firstCamera),
      '/library': (context) => LibraryPage(),
      '/setting': (context) => SettingsPage(),
      '/alphabet': (context) => AlphabetPage(),
      '/word': (context) => WordPage(),
      '/a': (context) => APage(),
      '/b': (context) => BPage(),
      '/c': (context) => CPage(),
      '/d': (context) => DPage(),
      '/hello': (context) => HelloPage(),
      '/thankyou': (context) => ThankyouPage(),
      '/love': (context) => LovePage(),
      '/think': (context) => ThinkPage(),
      '/different': (context) => DifferentPage(),
      '/course': (context) => CoursePage(),
    },
  ));
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'ThinKayTa',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: SplashScreen(), // Set SplashScreen as the initial route
//     );
//   }
// }
