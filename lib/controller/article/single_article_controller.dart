import 'package:get/get.dart';
import 'package:techblog/constant/api_constant.dart';
import 'package:techblog/services/dio_service.dart';
import 'package:techblog/view/articles/single.dart';
import 'package:techblog/models/article_info_model.dart';
import 'package:techblog/models/article_model.dart';
import 'package:techblog/models/tags_model.dart';

class SingleArticleController extends GetxController {
  RxBool isLoading = false.obs;
  RxInt id = RxInt(0);
  Rx<ArticleInfoModel> articleInfo = ArticleInfoModel().obs;
  RxList<TagsModel> tagList = RxList();
  RxList<ArticleModel> relatedList = RxList();

  getArticleInfo(var id) async {
    articleInfo = ArticleInfoModel().obs;
    isLoading.value = true;
    // todo userId is hard code
    String userId = '';
    var response = await DioService().getMethod('${ApiUrlConstant.baseUrl}article/get.php?command=info&id=$id&user_id=$userId');
    if (response.statusCode == 200) {
      articleInfo.value = ArticleInfoModel.fromJson(response.data);
      tagList.clear();
      response.data['tags'].forEach((element) {
        tagList.add(TagsModel.fromJson(element));
      });

      relatedList.clear();
      response.data['related'].forEach((element) {
        relatedList.add(ArticleModel.fromJson(element));
      });
      isLoading.value = false;
      Get.to(() => Single());
    }
  }
}
