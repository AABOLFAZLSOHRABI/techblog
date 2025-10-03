import 'package:get/get.dart';
import 'package:techblog/constant/api_constant.dart';
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
    var response = await DioService().getMethod(ApiUrlConstant.getArticleList);

    if (response.statusCode == 200) {
      response.data.forEach((element) {
        articleList.add(ArticleModel.fromJson(element));
      });
      isLoading.value = false;
    }
  }

  getArticleListWithTagsId(id) async {
    articleList.clear();
    isLoading.value = true;
    // TODO get userid from get storage

    final queryParam = {
    'command': 'get_articles_with_tag_id',
      'tag_id': id,
      'user_id':''
    };
    final uri = Uri.https(ApiUrlConstant.baseUrl,'article/get.php',queryParam);
    var response = await DioService().getMethod(uri.toString());

    if (response.statusCode == 200) {
      response.data.forEach((element) {
        articleList.add(ArticleModel.fromJson(element));
      });
      isLoading.value = false;
    }
  }
}
