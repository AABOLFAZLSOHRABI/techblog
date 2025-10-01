import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techblog/component/decorations.dart';
import 'package:techblog/component/dimens.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:techblog/controller/podcast/single_podcast_controller.dart';
import 'package:techblog/models/podcast_file_model.dart';
import 'package:techblog/models/podcast_model.dart';
import '../../component/my_component.dart';
import '../../constant/my_colors.dart';
import '../../constant/my_strings.dart';
import '../../gen/assets.gen.dart';
import '../../models/podcast_model.dart';

class SinglePodcast extends StatelessWidget {
  SinglePodcast({super.key});
  late SinglePodcastController singlePodcastController;
  late PodcastModel podcastModel;
  PodcastModel(){
    podcastModel = Get.arguments;
    singlePodcastController = Get.put(SinglePodcastController(id: podcastModel.id));
  }
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return SafeArea(
        child: Scaffold(
      body: Stack(children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: "",
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
                                  colors: GradientColors.singleAppbarGradiant)),
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
                  child: Align(
                    alignment: AlignmentGeometry.centerRight,
                    child: Text(
                      "عنوان پادکست",
                      maxLines: 2,
                      style: textTheme.titleLarge,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image(
                          image: AssetImage(Assets.images.profileAvatar.path),
                          height: 50),
                      const SizedBox(width: 16),
                      Text("نویسنده : ...",
                          style: textTheme.titleMedium!
                              .copyWith(color: SolidColors.textTitle)),
                      const SizedBox(width: 16),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: 5,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ImageIcon(
                                    Image.asset(Assets.icons.microphon.path)
                                        .image,
                                    color: SolidColors.seeMore),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  MyStrings.frilance,
                                  style: textTheme.titleMedium!
                                      .copyWith(color: SolidColors.textTitle),
                                ),
                              ],
                            ),
                            Text("22:00",
                                style: textTheme.titleMedium!
                                    .copyWith(color: SolidColors.textTitle)),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 8,
          left: Dimens.halfBodyMargin,
          right: Dimens.halfBodyMargin,
          child: Container(
            height: Get.height/7,
            decoration: MyDecorations.mainGradient,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  LinearPercentIndicator(
                    percent: 0.5,
                    backgroundColor: Colors.white,
                    progressColor: Colors.orange,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.skip_next_sharp,color: Colors.white),
                      Icon(Icons.play_circle_fill,color: Colors.white,size: 48),
                      Icon(Icons.skip_previous,color: Colors.white),
                      SizedBox(width: 16),
                      Icon(Icons.replay,color: Colors.white),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ]),
    ));
  }
}
