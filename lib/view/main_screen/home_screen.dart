import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techblog/component/my_strings.dart';
import 'package:techblog/controller/home_screen_controller.dart';
import 'package:techblog/controller/single_article_controller.dart';
import 'package:techblog/view/article_list_screen.dart';
import '../../gen/assets.gen.dart';
import '../../models/fake_data.dart';
import '../../component/my_colors.dart';
import '../../component/my_component.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
    required this.size,
    required this.textTheme,
    required this.bodyMargin,
  });

  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController());
  final SingleArticleController singleArticleController =
      Get.put(SingleArticleController());

  final Size size;
  final TextTheme textTheme;
  final double bodyMargin;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Obx(
        () => Padding(
          padding: const EdgeInsets.only(top: 16),
          child: homeScreenController.isLoading.value == false
              ? Column(
                  children: [
                    // Poster
                    poster(),
                    // tag list
                    const SizedBox(height: 16),
                    tags(),
                    const SizedBox(height: 16),
                    //see more (view hots blog)
                    HomeViewHotsBlogText(textTheme: textTheme),
                    const SizedBox(height: 16),
                    //blog list
                    topVisited(),
                    const SizedBox(height: 16),
                    //see more podcast (view hots podcast)
                    HomeViewPodcastText(textTheme: textTheme),
                    const SizedBox(height: 16),
                    //podcast list
                    topPodcasts(),
                    const SizedBox(height: 64),
                  ],
                )
              : const Loading(),
        ),
      ),
    );
  }

  Widget topVisited() {
    return SizedBox(
      height: size.height / 4.1,
      child: Obx(
        () => ListView.builder(
          itemCount: homeScreenController.topVisitedList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            //blog item
            return GestureDetector(
              onTap: () {
                singleArticleController.getArticleInfo(homeScreenController.topVisitedList[index].id);
              },
              child: Padding(
                padding: EdgeInsets.only(right: index == 0 ? bodyMargin : 15),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 8.0),
                      child: SizedBox(
                        height: size.height / 5.3,
                        width: size.width / 2.4,
                        child: Stack(
                          children: [
                            Container(
                                foregroundDecoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                  gradient: LinearGradient(
                                    colors: GradientColors.blogPost,
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.center,
                                  ),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: homeScreenController
                                      .topVisitedList[index].image!.trim(),
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(16)),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) => const Loading(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.image_not_supported,
                                    size: 50,
                                    color: SolidColors.greyColor,
                                  ),
                                )),
                            Positioned(
                              bottom: 8,
                              left: 0,
                              right: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                      homeScreenController
                                          .topVisitedList[index].author!,
                                      style: textTheme.bodyMedium),
                                  Row(
                                    children: [
                                      Text(
                                          homeScreenController
                                              .topVisitedList[index].view!,
                                          style: textTheme.bodyMedium),
                                      const SizedBox(width: 8),
                                      const Icon(
                                        Icons.remove_red_eye,
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
                      width: size.width / 2.4,
                      child: Text(
                          homeScreenController.topVisitedList[index].title!,
                          style: textTheme.bodySmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget topPodcasts() {
    return SizedBox(
      height: size.height / 4.1,
      child: ListView.builder(
        itemCount: homeScreenController.topPodcasts.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          //blog item
          return Padding(
            padding: EdgeInsets.only(right: index == 0 ? bodyMargin : 15),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 8.0),
                  child: SizedBox(
                    height: size.height / 5.3,
                    width: size.width / 2.4,
                    child: CachedNetworkImage(
                      imageUrl: homeScreenController.topPodcasts[index].poster!.trim(),
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
                ),
                SizedBox(
                  width: size.width / 2.4,
                  child: Text(homeScreenController.topPodcasts[index].author!,
                      style: textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget poster() {
    return Stack(
      children: [
        Container(
            width: size.width / 1.25,
            height: size.height / 4.2,
            foregroundDecoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              gradient: LinearGradient(
                colors: GradientColors.homePosterCoverGradiant,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: CachedNetworkImage(
              imageUrl: homeScreenController.poster.value.image!.trim(),
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover)),
              ),
              placeholder: (context, url) => const Loading(),
              errorWidget: (context, url, error) => const Icon(
                  Icons.image_not_supported,
                  size: 50,
                  color: SolidColors.greyColor),
            )),
        Positioned(
          bottom: 8,
          left: 0,
          right: 0,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                      "${HomePagePosterMap["writer"]} - ${HomePagePosterMap["data"]}",
                      style: textTheme.bodyMedium),
                  Row(
                    children: [
                      Text(HomePagePosterMap["views"],
                          style: textTheme.bodyMedium),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.remove_red_eye,
                        color: Colors.white,
                        size: 16,
                      ),
                    ],
                  ),
                ],
              ),
              Text(homeScreenController.poster.value.title!,
                  style: textTheme.bodyLarge),
            ],
          ),
        )
      ],
    );
  }

  Widget tags() {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: Get.find<HomeScreenController>().tagsList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {

            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 8, index == 0 ? bodyMargin : 15, 8),
              child: MainTags(
                textTheme: textTheme,
                index: index,
              ),
            ),
          );
        },
      ),
    );
  }
}

class HomeViewPodcastText extends StatelessWidget {
  const HomeViewPodcastText({
    super.key,
    required this.textTheme,
  });

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 32),
      child: Row(
        children: [
          ImageIcon(
            AssetImage(Assets.icons.microphon.path),
            color: SolidColors.seeMore,
          ),
          const SizedBox(width: 8),
          Text(MyStrings.viewHotestPodCasts,
              style: textTheme.bodyLarge!.copyWith(color: SolidColors.seeMore))
        ],
      ),
    );
  }
}

class HomeViewHotsBlogText extends StatelessWidget {
  const HomeViewHotsBlogText({
    super.key,
    required this.textTheme,
  });

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(ArticleListScreen()),
      child: Padding(
        padding: const EdgeInsets.only(right: 32),
        child: Row(
          children: [
            ImageIcon(
              AssetImage(Assets.icons.bluePen.path),
              color: SolidColors.seeMore,
            ),
            const SizedBox(width: 8),
            Text(MyStrings.viewHotestBlog,
                style: textTheme.bodyLarge!.copyWith(color: SolidColors.seeMore))
          ],
        ),
      ),
    );
  }
}
