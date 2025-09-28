import 'package:get/get.dart';
import 'package:techblog/controller/article/list_article_controller.dart';
import 'package:techblog/controller/article/manage_article_controller.dart';
import 'controller/article/single_article_controller.dart';
import 'controller/register_controller.dart';

class ArticleBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SingleArticleController());
    Get.lazyPut(() => ListArticleController());
  }
}

class ArticleManagerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ManageArticleController());
  }
}

class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController());
  }
}