import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:techblog/my_colors.dart';
import 'package:techblog/view/register_intro.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
    var textTheme = Theme.of(context).textTheme;
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
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          )),
          textStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return textTheme.headlineSmall;
            } else {
              return textTheme.titleLarge;
            }
          }),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return SolidColors.posterTitle;
            } else {
              return SolidColors.primaryColor;
            }
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return SolidColors.primaryColor;
            } else {
              return SolidColors.posterTitle;
            }
          }),
        )),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(width: 2),
          ),

          filled: true,
          fillColor: SolidColors.statusBarColor,
        ),
        fontFamily: 'dana',
        brightness: Brightness.light,
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
          displaySmall: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          headlineLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
          headlineMedium:
              TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
          headlineSmall: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),

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
      home: const RegisterIntro(),
    );
  }
}
