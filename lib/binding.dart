import 'package:get/get.dart';
import 'package:techblog/controller/list_article_controller.dart';
import 'controller/register_controller.dart';
import 'controller/single_article_controller.dart';

class ArticleBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SingleArticleController());
    Get.lazyPut(() => ListArticleController());
  }
}

class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController());
  }
}