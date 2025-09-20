import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techblog/view/single.dart';
import '../component/my_colors.dart';
import '../component/my_component.dart';
import '../controller/list_article_controller.dart';
import '../controller/single_article_controller.dart';

class ArticleListScreen extends StatelessWidget {
  ArticleListScreen({super.key});

  final ListArticleController listArticleController =
      Get.put(ListArticleController());
  final SingleArticleController singleArticleController =
      Get.put(SingleArticleController());

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: appBar("مقالات جدید"),
      body: Obx(
        () => listArticleController.isLoading.value == false
            ? ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: listArticleController.articleList.length,
                itemBuilder: (context, index) {
                  final article = listArticleController.articleList[index];

                  return GestureDetector(
                    onTap: () {
                      singleArticleController.id.value = int.parse(
                          listArticleController.articleList[index].id
                              .toString());
                      Get.to( const Single());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            height: size.height / 6,
                            width: size.width / 3,
                            child: CachedNetworkImage(
                              imageUrl: article.image ?? '',
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16)),
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover)),
                              ),
                              placeholder: (context, url) => const Loading(),
                              errorWidget: (context, url, error) => const Icon(
                                  Icons.image_not_supported,
                                  size: 50,
                                  color: SolidColors.greyColor),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  article.title ?? 'بدون عنوان',
                                  style: textTheme.bodyLarge!
                                      .copyWith(color: SolidColors.textTitle),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text(article.author ?? 'نامشخص',
                                        style: textTheme.bodyMedium!.copyWith(
                                            color: SolidColors.greyColor)),
                                    const SizedBox(width: 8),
                                    Text(article.view ?? '0',
                                        style: textTheme.bodyMedium!.copyWith(
                                            color: SolidColors.greyColor)),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              )
            : const Loading(),
      ),
    ));
  }
}
