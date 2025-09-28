import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:techblog/constant/my_colors.dart';
import 'package:techblog/controller/article/list_article_controller.dart';
import 'package:techblog/gen/assets.gen.dart';
import 'package:techblog/view/articles/article_list_screen.dart';
import '../../component/my_component.dart';
import '../../controller/article/single_article_controller.dart';

class Single extends StatelessWidget {
  Single({super.key});

  final singleArticleController =
      Get.find<SingleArticleController>();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Obx(
          () => singleArticleController.articleInfo.value.image == null
              ? SizedBox(
              height: Get.height,
              child: const Loading())
              : Column(
                  children: [
                    Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl:
                              singleArticleController.articleInfo.value.image!.trim(),
                          imageBuilder: (context, imageProvider) =>
                              Image(image: imageProvider),
                          placeholder: (context, url) => const Loading(),
                          errorWidget: (context, url, error) =>
                              Image.asset(Assets.images.singlePlaceHolder.path),
                        ),
                        Positioned(
                            top: 0,
                            right: 0,
                            left: 0,
                            child: Container(
                              height: 60,
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                      end: Alignment.bottomCenter,
                                      begin: Alignment.topCenter,
                                      colors:
                                          GradientColors.singleAppbarGradiant)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const SizedBox(width: 20),
                                  InkWell(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: const Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                  const Expanded(child: SizedBox()),
                                  const Icon(
                                    Icons.bookmark_border_rounded,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 20),
                                  const Icon(
                                    Icons.share,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 20),
                                ],
                              ),
                            ))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        singleArticleController.articleInfo.value.title!,
                        maxLines: 2,
                        style: textTheme.titleLarge,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image(
                              image:
                                  AssetImage(Assets.images.profileAvatar.path),
                              height: 50),
                          const SizedBox(width: 16),
                          Text(
                              singleArticleController.articleInfo.value.author!,
                              style: textTheme.titleMedium!
                                  .copyWith(color: SolidColors.textTitle)),
                          const SizedBox(width: 16),
                          Text(
                              singleArticleController
                                  .articleInfo.value.createdAt!,
                              style: textTheme.titleSmall),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: HtmlWidget(
                        singleArticleController.articleInfo.value.content!,
                        textStyle: const TextStyle(color: Colors.black),
                        enableCaching: true,
                        onLoadingBuilder: (context, element, loadingProgress) =>
                            const Loading(),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: tags(textTheme),
                    ),
                    const SizedBox(height: 25),
                    similar(textTheme),
                  ],
                ),
        ),
      ),
    ));
  }

  SizedBox tags(TextTheme textTheme) {
    return SizedBox(
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: singleArticleController.tagList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              var tagId = singleArticleController.tagList[index].id!;
              await Get.find<ListArticleController>()
                  .getArticleListWithTagsId(tagId);
              Get.to(()=> ArticleListScreen());
            },
            child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Container(
                  height: 30,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                      color: SolidColors.greyColor),
                  child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: Text(
                        singleArticleController.tagList[index].title!,
                        style: textTheme.titleSmall!
                            .copyWith(color: SolidColors.hashTag),
                      )),
                )),
          );
        },
      ),
    );
  }

  SizedBox similar(TextTheme textTheme) {
    return SizedBox(
      height: Get.height / 3.5,
      child: ListView.builder(
          itemCount: singleArticleController.relatedList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: ((context, index) {
            //blog item
            return GestureDetector(
              onTap: () {
                singleArticleController.getArticleInfo(singleArticleController.relatedList[index].id);
              },
              child: Padding(
                padding: EdgeInsets.only(right: index == 0 ? Get.width / 15 : 15),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: Get.height / 5.3,
                        width: Get.width / 2.4,
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl: singleArticleController
                                  .relatedList[index].image!.trim(),
                              imageBuilder: ((context, imageProvider) =>
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(16)),
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
                                    ),
                                    foregroundDecoration: const BoxDecoration(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(16)),
                                        gradient: LinearGradient(
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                            colors: GradientColors.blogPost)),
                                  )),
                              placeholder: ((context, url) => const Loading()),
                              errorWidget: ((context, url, error) => const Icon(
                                    Icons.image_not_supported_outlined,
                                    size: 50,
                                    color: Colors.grey,
                                  )),
                            ),
                            Positioned(
                              bottom: 8,
                              left: 0,
                              right: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    singleArticleController
                                        .relatedList[index].author!,
                                    style: textTheme.titleSmall!
                                        .copyWith(color: SolidColors.posterTitle),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        singleArticleController
                                            .relatedList[index].view!,
                                        style: textTheme.titleSmall!.copyWith(
                                            color: SolidColors.posterSubTitle),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      const Icon(
                                        Icons.remove_red_eye_sharp,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                        width: Get.width / 2.4,
                        child: Text(
                          singleArticleController.relatedList[index].title!,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.titleLarge!
                              .copyWith(color: SolidColors.textTitle),
                          maxLines: 2,
                        ))
                  ],
                ),
              ),
            );
          })),
    );
  }
}
