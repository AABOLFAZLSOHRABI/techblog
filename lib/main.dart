import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:techblog/my_colors.dart';
import 'package:techblog/view/register_intro.dart';
import 'view/splash_screen.dart';

void main() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: SolidColors.statusBarColor,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: SolidColors.statusBarColor,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Localizations Sample App',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fa'), // farsi
      ],
      theme: ThemeData(
        fontFamily: 'dana',
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
          displaySmall: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          headlineLarge:
              TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
          headlineMedium:
              TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
          headlineSmall:
              TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),

          titleLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
          // poster font labile
          bodyLarge: TextStyle(
              fontSize: 18.0,
              color: SolidColors.posterTitle,
              fontWeight: FontWeight.bold),
          bodyMedium:
              TextStyle(fontSize: 14.0, color: SolidColors.posterSubTitle),
          bodySmall: TextStyle(fontSize: 12.0),
          // font labile blue color
          titleMedium: TextStyle(
              fontSize: 14.0,
              color: SolidColors.seeMore,
              fontWeight: FontWeight.w700),
        ),
      ),
      home: RegisterIntro(),
    );
  }
}
