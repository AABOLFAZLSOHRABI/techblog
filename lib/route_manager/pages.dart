import 'package:get/get.dart';
import 'package:techblog/view/podcast/single_podcast.dart';
import 'package:techblog/view/splash_screen.dart';
import 'package:techblog/route_manager/binding.dart';
import 'package:techblog/view/articles/manage_article.dart';
import 'package:techblog/view/articles/single.dart';
import 'package:techblog/view/articles/single_manage_article.dart';
import 'package:techblog/view/main_screen/main_screen.dart';

class Pages {
  Pages._();
  static List<GetPage<dynamic>> pages = [
    GetPage(
        name: NamedRoute.initialRoute,
        page: () => const SplashScreen()),
    GetPage(
        name: NamedRoute.routeMainScreen,
        page: () => MainScreen(),
        binding: RegisterBinding()),
    GetPage(
        name: NamedRoute.routeSingleArticle,
        page: () => Single(),
        binding: ArticleBinding()),
    GetPage(
        name: NamedRoute.routeManageArticle,
        page: () => ManageArticle(),
        binding: ArticleManagerBinding()),
    GetPage(
        name: NamedRoute.routeSingleManageArticle,
        page: () => SingleManageArticle(),
        binding: ArticleManagerBinding()),
    GetPage(name: NamedRoute.routeSinglePodcast, page: () => SinglePodcast()),
  ];
}

class NamedRoute {
  NamedRoute._();

  static String routeMainScreen = '/MainScreen';
  static String routeSingleArticle = '/SingleArticle';
  static String routeManageArticle = '/ManageArticle';
  static String routeSingleManageArticle = '/SingleManageArticle';
  static String routeSinglePodcast = '/SinglePodcast';
  static String initialRoute = '/';
}
