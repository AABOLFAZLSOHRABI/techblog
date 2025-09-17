import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../component/my_colors.dart';
import '../component/my_component.dart';
import '../controller/article_controller.dart';

class ArticleListScreen extends StatelessWidget {
  ArticleListScreen({super.key});

  final ArticleController articleController = Get.put(ArticleController());

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
          appBar: appBar("مقالات جدید"),
          body: Obx(
                () => articleController.isLoading.value == false
                ? ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: articleController.articleList.length,
              itemBuilder: (context, index) {

                final article = articleController.articleList[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: size.height / 5.3,
                        width: size.width / 2.4,
                        child: CachedNetworkImage(
                          imageUrl: article.image ?? '',
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                const BorderRadius.all(Radius.circular(16)),
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover)),
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
                                    style: textTheme.bodyMedium!
                                        .copyWith(color: SolidColors.greyColor)),
                                const SizedBox(width: 8),
                                Text(article.view ?? '0',
                                    style: textTheme.bodyMedium!
                                        .copyWith(color: SolidColors.greyColor)),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            )
                : const Loading(),
          ),
        ));
  }
}