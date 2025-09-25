import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:techblog/component/my_component.dart';
import 'package:techblog/component/my_strings.dart';
import 'package:techblog/controller/register_controller.dart';
import 'package:techblog/view/main_screen/home_screen.dart';
import 'package:techblog/view/main_screen/profile_screen.dart';
import 'package:techblog/view/register/register_intro.dart';
import '../../component/my_colors.dart';
import '../../gen/assets.gen.dart';
import 'package:get/get.dart';

final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
var registerController = Get.find<RegisterController>();
class MainScreen extends StatelessWidget {
  final RxInt selectedPageIndex = 0.obs;

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    double bodyMargin = size.width / 10;

    return SafeArea(
      child: Scaffold(
        key: _key,
        extendBody: true,
        drawer: Drawer(
          backgroundColor: SolidColors.surface,
          child: ListView(
            children: [
              DrawerHeader(
                  child: Image.asset(
                Assets.images.logo.path,
                scale: 3,
              )),
              ListTile(
                title: Text(MyStrings.userProfile),
                onTap: () {},
              ),
              const Divider(color: SolidColors.greyColor),
              ListTile(
                title: Text(MyStrings.aboutTec),
                onTap: () {},
              ),
              const Divider(color: SolidColors.greyColor),
              ListTile(
                title: Text(MyStrings.shareTec),
                onTap: () async {
                  await SharePlus.instance
                      .share(ShareParams(text: MyStrings.shareText));
                },
              ),
              const Divider(color: SolidColors.greyColor),
              ListTile(
                title: Text(MyStrings.tecIngithub),
                onTap: () {
                  myLunchUrl(MyStrings.techBlogGithubUrl);
                },
              ),
            ],
          ),
        ),
        //app bar
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: SolidColors.scaffoldBg,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                  onTap: () {
                    _key.currentState!.openDrawer();
                  },
                  child: const Icon(Icons.menu, color: Colors.black)),
              Image.asset(Assets.images.logo.path, width: size.height / 13.6),
              const Icon(Icons.search, color: Colors.black)
            ],
          ),
        ),
        // body
        body: Obx(() => IndexedStack(
              index: selectedPageIndex.value,
              children: [
                HomeScreen(
                    size: size, textTheme: textTheme, bodyMargin: bodyMargin),
                ProfileScreen(
                    size: size, textTheme: textTheme, bodyMargin: bodyMargin),
                RegisterIntro(),
              ],
            )),
        // menuBar bottom
        bottomNavigationBar: BottomNavBar(
          size: size,
          bodyMargin: bodyMargin,
          changeScreen: (int value) {
            selectedPageIndex.value = value;
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
                onPressed: () {
                  registerController.toggleLogin();
                },
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
