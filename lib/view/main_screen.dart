import 'package:flutter/material.dart';
import 'package:techblog/view/home_screen.dart';
import 'package:techblog/view/profile_screen.dart';
import '../gen/assets.gen.dart';
import '../my_colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    double bodyMargin = size.width / 10;

    return SafeArea(
      child: Scaffold(
        extendBody: true,
        //app bar
        appBar: AppBar(
          elevation: 0,
          backgroundColor: SolidColors.scaffoldBg,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Icon(Icons.menu, color: Colors.black),
              Image.asset(Assets.images.logo.path, width: size.height / 13.6),
              const Icon(Icons.search, color: Colors.black)
            ],
          ),
        ),
        // body
        body: IndexedStack(
                  index: selectedPageIndex,
                  children: [
        HomeScreen(
            size: size, textTheme: textTheme, bodyMargin: bodyMargin),
        ProfileScreen(
            size: size, textTheme: textTheme, bodyMargin: bodyMargin)
                  ],
                ),
        // menuBar bottom
        bottomNavigationBar: BottomNavBar(
          size: size,
          bodyMargin: bodyMargin,
          changeScreen: (int value) {
            setState(() {
              selectedPageIndex = value;
            });
          },
        ),
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.size,
    required this.bodyMargin,
    required this.changeScreen,
  });

  final Size size;
  final double bodyMargin;
  final Function(int) changeScreen;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height / 10,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: GradientColors.bottomNavBackground,
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )),
      child: Padding(
        padding: EdgeInsets.only(
            left: bodyMargin, right: bodyMargin, top: 8, bottom: 8),
        child: Container(
          height: size.height / 8,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(18)),
              gradient: LinearGradient(
                colors: GradientColors.bottomNav,
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () => changeScreen(0),
                icon: ImageIcon(AssetImage(Assets.icons.home.path)),
                color: Colors.white,
              ),
              IconButton(
                onPressed: () {},
                icon: ImageIcon(AssetImage(Assets.icons.write.path)),
                color: Colors.white,
              ),
              IconButton(
                onPressed: () => changeScreen(1),
                icon: ImageIcon(AssetImage(Assets.icons.user.path)),
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
