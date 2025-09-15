import 'package:get/get.dart';
import 'package:techblog/component/api_constant.dart';
import 'package:techblog/models/podcast_model.dart';
import 'package:techblog/models/poster_model.dart';
import 'package:techblog/models/article_model.dart';
import 'package:techblog/services/dio_service.dart';
import '../models/tags_model.dart';

class HomeScreenController extends GetxController {
  late Rx<PosterModel> poster = PosterModel().obs;
  RxList<TagsModel> tagsList = RxList();
  RxList<ArticleModel> topVisitedList = RxList();
  RxList<PodcastModel> topPodcasts = RxList();
  RxBool isLoading = false.obs;

  @override
  onInit() {
    super.onInit();
    getHomeItems();
  }

  getHomeItems() async {
    isLoading.value = true;
    var response = await DioService().getMethod(ApiConstant.getHomeItems);

    if (response.statusCode == 200) {
      poster.value = PosterModel.fromJson(response.data['poster']);
      response.data['tags'].forEach((element) {
        tagsList.add(TagsModel.fromJson(element));
      });
      response.data['top_visited'].forEach((element) {
        topVisitedList.add(ArticleModel.fromJson(element));
      });
      response.data['top_podcasts'].forEach((element) {
        topPodcasts.add(PodcastModel.fromJson(element));
      });
      isLoading.value = false;
    }
  }
}
