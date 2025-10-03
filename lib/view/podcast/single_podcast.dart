import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techblog/component/decorations.dart';
import 'package:techblog/component/dimens.dart';
import 'package:techblog/controller/podcast/single_podcast_controller.dart';
import 'package:techblog/models/podcast_model.dart';
import 'package:techblog/component/my_component.dart';
import 'package:techblog/constant/my_colors.dart';
import 'package:techblog/gen/assets.gen.dart';

class SinglePodcast extends StatelessWidget {
  late final SinglePodcastController controller;
  late final PodcastModel podcastModel;
  SinglePodcast({super.key}){
    podcastModel = Get.arguments;
    controller = Get.put(SinglePodcastController(id: podcastModel.id));
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
                    SizedBox(
                      height: Get.height / 3,
                      width: Get.width,
                      child: CachedNetworkImage(
                        imageUrl: podcastModel.poster!,
                        imageBuilder: (context, imageProvider) =>
                            Image(image: imageProvider, fit: BoxFit.fill),
                        placeholder: (context, url) => const Loading(),
                        errorWidget: (context, url, error) =>
                            Image.asset(Assets.images.singlePlaceHolder.path),
                      ),
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
                      podcastModel.title!,
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
                      Text(podcastModel.author!,
                          style: textTheme.titleMedium!
                              .copyWith(color: SolidColors.textTitle)),
                      const SizedBox(width: 16),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(
                    () =>  ListView.builder(
                      itemCount: controller.podcastFileList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            controller.player.seek(Duration.zero,index: index);
                            controller.currentFileIndex.value = controller.player.currentIndex!;
                            controller.timerCheckIndexChange();
                          },
                          child: Padding(
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
                                    SizedBox(
                                      width: Get.width / 1.5,
                                      child: Obx(
                                        () => Text(
                                          controller
                                              .podcastFileList[index].title!,
                                          style:controller.currentFileIndex.value==index?textTheme.titleMedium!.copyWith(
                                              color: SolidColors.seeMore):textTheme.titleMedium!.copyWith(
                                              color: SolidColors.textTitle)
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                    "${controller.podcastFileList[index].length!}:00",
                                    style: textTheme.titleMedium!
                                        .copyWith(color: SolidColors.textTitle)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
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
                  Obx(
                    () => ProgressBar(
                        timeLabelTextStyle: textTheme.titleSmall,
                        thumbColor: Colors.orange,
                        progressBarColor: Colors.orange,
                        baseBarColor: Colors.white,
                        bufferedBarColor: Colors.white70,
                        buffered: controller.bufferedValue.value,
                        progress: controller.progressValue.value,
                        total: controller.player.duration?? const Duration(seconds: 0),
                        onSeek: (value) {
                          controller.player.seek(value);
                          controller.player.playing?
                          controller.startProgress():
                          controller.timer!.cancel();
                          },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                          onTap: () async {
                            await controller.player.seekToNext();
                            controller.currentFileIndex.value = controller.player.currentIndex!;
                            controller.timerCheckIndexChange();
                          },
                          child: const Icon(
                              Icons.skip_next_sharp, color: Colors.white)),
                      GestureDetector(
                        onTap: () {
                          controller.playState.value?
                          controller.player.pause():
                          controller.player.play();

                          controller.playState.value?
                          controller.timer!.cancel():
                          controller.startProgress();

                          controller.playState.value = controller.player.playing;
                        },
                          child: Obx(
                            () => Icon(
                                controller.playState.value?
                                Icons.pause_circle_filled:
                                Icons.play_circle_fill,
                                color: Colors.white, size: 48),
                          )),
                      GestureDetector(
                          onTap: () async {
                            await controller.player.seekToPrevious();
                            controller.timerCheckIndexChange();
                          },
                          child: const Icon(Icons.skip_previous,
                              color: Colors.white)),
                      const SizedBox(width: 16),
                      Obx(() => GestureDetector(
                            onTap: () {
                              controller.isLoopAll;
                            },
                            child:
                            controller.isLoopAll.value?
                            const Icon(Icons.replay_5,color:Colors.blue):
                            const Icon(Icons.replay,color:Colors.white),
                          ))
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
