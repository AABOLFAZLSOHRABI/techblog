import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:techblog/my_colors.dart';
import 'splash_screen.dart';
import 'main_screen.dart';
// import 'gen/assets.gen.dart';

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
          headlineMedium:
              TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
          titleLarge: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
          bodyLarge: TextStyle(fontSize: 16.0, color: SolidColors.posterTitle),
          bodyMedium:
              TextStyle(fontSize: 14.0, color: SolidColors.posterSubTitle),
          bodySmall: TextStyle(fontSize: 12.0),
        ),
      ),
      home: SplashScreen(),
    );
  }
}
