import 'package:get/get.dart';
import 'package:techblog/component/api_constant.dart';
import 'package:techblog/models/article_model.dart';
import 'package:techblog/services/dio_service.dart';

class ListArticleController extends GetxController {
  RxList<ArticleModel> articleList = RxList();
  RxBool isLoading = false.obs;

  @override
  onInit() {
    super.onInit();
    getList();
  }

  getList() async {
    isLoading.value = true;
    // TODO get userid from get storage
    var response = await DioService().getMethod(ApiConstant.getArticleList);

    if (response.statusCode == 200) {
      response.data.forEach((element) {
        articleList.add(ArticleModel.fromJson(element));
      });
      isLoading.value = false;
    }
  }
}
