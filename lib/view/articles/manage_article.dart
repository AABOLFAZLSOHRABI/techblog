import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techblog/constant/my_colors.dart';
import 'package:techblog/component/my_component.dart';
import 'package:techblog/constant/my_strings.dart';
import 'package:techblog/controller/article/manage_article_controller.dart';
import '../../gen/assets.gen.dart';
import '../../main.dart';

class ManageArticle extends StatelessWidget {
  ManageArticle({super.key});

  final manageArticleController = Get.find<ManageArticleController>();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: appBar(MyStrings.titleAppBarManageArticle),
      body: Obx(
        () => manageArticleController.loading.value
            ? const Loading()
            : manageArticleController.articleList.isNotEmpty == true
                ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: manageArticleController.articleList.length,
                    itemBuilder: (context, index) {
                      final article =
                          manageArticleController.articleList[index];

                      return GestureDetector(
                        onTap: () {
                          // route to single edit article
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              SizedBox(
                                height: size.height / 6,
                                width: size.width / 3,
                                child: CachedNetworkImage(
                                  imageUrl: (article.image ?? '').trim(),
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(16)),
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover)),
                                  ),
                                  placeholder: (context, url) =>
                                      const Loading(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.image_not_supported,
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
                                      style: textTheme.bodyLarge!.copyWith(
                                          color: SolidColors.textTitle),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text(article.author ?? 'نامشخص',
                                            style: textTheme.bodyMedium!
                                                .copyWith(
                                                    color:
                                                        SolidColors.greyColor)),
                                        const SizedBox(width: 8),
                                        Text(article.view ?? '0',
                                            style: textTheme.bodyMedium!
                                                .copyWith(
                                                    color:
                                                        SolidColors.greyColor)),
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
                : articleEmptyState(context, textTheme),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(0, 36),
            ),
            onPressed: () {
              Get.toNamed(NamedRoute.routeSingleManageArticle);
            },
            child: Text(
              MyStrings.textManageArticle,
              style: textTheme.titleMedium!
                  .copyWith(color: SolidColors.posterTitle),
            )),
      ),
    ));
  }

  Widget articleEmptyState(BuildContext context, TextTheme textTheme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
              image: Image.asset(Assets.images.emptyState.path).image,
              height: 100),
          Padding(
            padding: const EdgeInsets.only(top: 34),
            child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: MyStrings.podcastEmpty,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: SolidColors.textTitle))),
          ),
        ],
      ),
    );
  }
}
