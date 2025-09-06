import 'package:flutter/material.dart';
import 'package:techblog/my_strings.dart';
import 'gen/assets.gen.dart';
import 'models/fake_data.dart';
import 'my_colors.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    double bodyMargin = size.width / 10;
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        //app bar
        appBar: AppBar(
          elevation: 0,
          backgroundColor: SolidColors.scaffoldBg,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Icon(Icons.menu, color: Colors.black),
              Image.asset(Assets.images.logo.path, width: size.height / 13.6),
              const Icon(Icons.search, color: Colors.black)
            ],
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Column(
              children: [
                // Poster
                Stack(
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
                ),
                // tag list
                const SizedBox(height: 16),
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: tagList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.fromLTRB(
                            0, 8, index == 0 ? bodyMargin : 15, 8),
                        child: Container(
                          height: 60,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                            gradient: LinearGradient(
                                colors: GradientColors.tags,
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: Row(
                              children: [
                                ImageIcon(
                                  AssetImage(Assets.icons.hashtagicon.path),
                                  color: Colors.white,
                                  size: 16,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  tagList[index].title,
                                  style: textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                //see more (view hots blog)
                Padding(
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
                ),
                const SizedBox(height: 16),
                //blog list
                SizedBox(
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
                              padding: const EdgeInsets.all(8.0),
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
                ),
                const SizedBox(height: 16),
                //see more podcast (view hots podcast)
                Padding(
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
                ),
                const SizedBox(height: 16),
                //podcast list
                SizedBox(
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
                              padding: const EdgeInsets.all(8.0),
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
                ),
                const SizedBox(height: 64),
              ],
            ),
          ),
        ),
        bottomNavigationBar:
        Container(
          height: size.height / 10,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: GradientColors.bottomNavBackground,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              height: size.height / 8,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                  gradient: LinearGradient(
                    colors: GradientColors.bottomNav,
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: ImageIcon(AssetImage(Assets.icons.home.path)),
                    color: Colors.white,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: ImageIcon(AssetImage(Assets.icons.write.path)),
                    color: Colors.white,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: ImageIcon(AssetImage(Assets.icons.user.path)),
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
