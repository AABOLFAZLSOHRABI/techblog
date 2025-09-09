import 'package:flutter/material.dart';
import 'package:techblog/my_strings.dart';
import '../gen/assets.gen.dart';
import '../models/fake_data.dart';
import '../my_colors.dart';
import '../my_component.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.size,
    required this.textTheme,
    required this.bodyMargin,
  });

  final Size size;
  final TextTheme textTheme;
  final double bodyMargin;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          children: [
            // Poster
            HomePoster(size: size, textTheme: textTheme),
            // tag list
            const SizedBox(height: 16),
            HomeTagList(bodyMargin: bodyMargin, textTheme: textTheme),
            const SizedBox(height: 16),
            //see more (view hots blog)
            HomeViewHotsBlogText(textTheme: textTheme),
            const SizedBox(height: 16),
            //blog list
            HomeBlogList(size: size, bodyMargin: bodyMargin, textTheme: textTheme),
            const SizedBox(height: 16),
            //see more podcast (view hots podcast)
            HomeViewPodcastText(textTheme: textTheme),
            const SizedBox(height: 16),
            //podcast list
            HomePodcastList(size: size, bodyMargin: bodyMargin, textTheme: textTheme),
            const SizedBox(height: 64),
          ],
        ),
      ),
    );
  }
}

class HomePodcastList extends StatelessWidget {
  const HomePodcastList({
    super.key,
    required this.size,
    required this.bodyMargin,
    required this.textTheme,
  });

  final Size size;
  final double bodyMargin;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height / 4.1,
      child: ListView.builder(
        itemCount: blogList.getRange(0, 5).length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          //blog item
          return Padding(
            padding: EdgeInsets.only(
                right: index == 0 ? bodyMargin : 15),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                  child: SizedBox(
                    height: size.height / 5.3,
                    width: size.width / 2.4,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                                Radius.circular(16)),
                            image: DecorationImage(
                              image: NetworkImage(
                                  blogList[index].imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width / 2.4,
                  child: Text(blogList[index].writer,
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
              style: textTheme.bodyLarge!
                  .copyWith(color: SolidColors.seeMore))
        ],
      ),
    );
  }
}

class HomeBlogList extends StatelessWidget {
  const HomeBlogList({
    super.key,
    required this.size,
    required this.bodyMargin,
    required this.textTheme,
  });

  final Size size;
  final double bodyMargin;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height / 4.1,
      child: ListView.builder(
        itemCount: blogList.getRange(0, 5).length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          //blog item
          return Padding(
            padding: EdgeInsets.only(
                right: index == 0 ? bodyMargin : 15),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                  child: SizedBox(
                    height: size.height / 5.3,
                    width: size.width / 2.4,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                                Radius.circular(16)),
                            image: DecorationImage(
                              image: NetworkImage(
                                  blogList[index].imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                          foregroundDecoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(16)),
                            gradient: LinearGradient(
                              colors: GradientColors.blogPost,
                              begin: Alignment.bottomCenter,
                              end: Alignment.center,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 8,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceAround,
                            children: [
                              Text(blogList[index].writer,
                                  style: textTheme.bodyMedium),
                              Row(
                                children: [
                                  Text(blogList[index].views,
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
                  child: Text(blogList[index].title,
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
}

class HomeViewHotsBlogText extends StatelessWidget {
  const HomeViewHotsBlogText({
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
            AssetImage(Assets.icons.bluePen.path),
            color: SolidColors.seeMore,
          ),
          const SizedBox(width: 8),
          Text(MyStrings.viewHotestBlog,
              style: textTheme.bodyLarge!
                  .copyWith(color: SolidColors.seeMore))
        ],
      ),
    );
  }
}

class HomeTagList extends StatelessWidget {
  const HomeTagList({
    super.key,
    required this.bodyMargin,
    required this.textTheme,
  });

  final double bodyMargin;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tagList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.fromLTRB(
                0, 8, index == 0 ? bodyMargin : 15, 8),
            child: MainTags(textTheme: textTheme, index: index,),
          );
        },
      ),
    );
  }
}

class HomePoster extends StatelessWidget {
  const HomePoster({
    super.key,
    required this.size,
    required this.textTheme,
  });

  final Size size;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: size.width / 1.25,
            height: size.height / 4.2,
            decoration: BoxDecoration(
              borderRadius:
              const BorderRadius.all(Radius.circular(16)),
              image: DecorationImage(
                image: AssetImage(HomePagePosterMap["imageAsset"]),
                fit: BoxFit.cover,
              ),
            ),
            foregroundDecoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              gradient: LinearGradient(
                colors: GradientColors.homePosterCoverGradiant,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
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
              Text(HomePagePosterMap["title"],
                  style: textTheme.bodyLarge),
            ],
          ),
        )
      ],
    );
  }
}
