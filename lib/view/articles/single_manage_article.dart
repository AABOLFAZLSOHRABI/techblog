import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techblog/constant/my_colors.dart';
import 'package:techblog/constant/my_strings.dart';
import 'package:techblog/controller/article/list_article_controller.dart';
import 'package:techblog/controller/article/manage_article_controller.dart';
import 'package:techblog/gen/assets.gen.dart';
import 'package:techblog/view/articles/article_list_screen.dart';
import '../../component/dimens.dart';
import '../../component/my_component.dart';
import '../../controller/file_controller.dart';
import '../../services/pick_file.dart';

class SingleManageArticle extends StatelessWidget {
  SingleManageArticle({super.key});

  final manageArticleController = Get.find<ManageArticleController>();
  final FilePickerController filePickerController =
      Get.put(FilePickerController());

  getTitle() {
    Get.defaultDialog(
      title: MyStrings.titleDialogSingleManageArticle,
      content: TextField(
        controller: manageArticleController.titleEditingController,
        keyboardType: TextInputType.text,
        style: const TextStyle(color: SolidColors.colorTitle),
        decoration: InputDecoration(
          hintText: MyStrings.hintTextSingleManageArticle,
        ),
      ),
      onConfirm: () {},
      radius: 8,
      confirm: ElevatedButton(
          onPressed: () {
            manageArticleController.updateTitle();
            Get.back();
          },
          child: Text(MyStrings.save)),
    );
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Obx(
          () => Column(
            children: [
              Stack(
                children: [
                  /// image cover post
                  SizedBox(
                    width: Get.width,
                    child: filePickerController.file.value.size == 0
                        ? CachedNetworkImage(
                            imageUrl: manageArticleController
                                    .articleInfoModel.value.image ??
                                '',
                            imageBuilder: (context, imageProvider) =>
                                Image(image: imageProvider),
                            placeholder: (context, url) => const Loading(),
                            errorWidget: (context, url, error) => Image.asset(
                                Assets.images.singlePlaceHolder.path),
                          )
                        : Image.file(
                            File(filePickerController.file.value.path!),
                            fit: BoxFit.cover),
                  ),

                  /// Feature gradient image
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
                          ],
                        ),
                      )),

                  /// Feature button add image
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: InkWell(
                        onTap: () async {
                          await pickFile();
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                              color: SolidColors.primaryColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12))),
                          height: 30,
                          width: Get.width / 3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                MyStrings.selectImage,
                                style: textTheme.titleSmall!
                                    .copyWith(color: SolidColors.posterTitle),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.add,
                                  color: SolidColors.lightIcon),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30),

              /// edit text title article
              GestureDetector(
                onTap: () {
                  getTitle();
                },
                child: SeeMoreBlog(
                    textTheme: textTheme,
                    title: MyStrings.editTitleArticle,
                    bodyMargin: Dimens.halfBodyMargin),
              ),

              /// show text title article
              Padding(
                padding: EdgeInsets.all(Dimens.halfBodyMargin),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      manageArticleController.articleInfoModel.value.title ??
                          MyStrings.titltArrticle,
                      maxLines: 2,
                      textAlign: TextAlign.end,
                      style: textTheme.titleMedium!
                          .copyWith(color: SolidColors.textTitle),
                    ),
                  ],
                ),
              ),

              /// edit main text article
              GestureDetector(
                // onTap: () => Get.to(() => ArticleContentEditor()),
                child: SeeMoreBlog(
                    textTheme: textTheme,
                    title: MyStrings.editMainTextArticle,
                    bodyMargin: Dimens.halfBodyMargin),
              ),

              /// show main text article
              Padding(
                padding: EdgeInsets.all(Dimens.halfBodyMargin),
                child: Text(
                  manageArticleController.articleInfoModel.value.title ??
                      MyStrings.visit,
                  maxLines: 2,
                  style: textTheme.titleMedium!
                      .copyWith(color: SolidColors.textTitle),
                ),
              ),

              /// edit tags category
              SeeMoreBlog(
                  textTheme: textTheme,
                  title: MyStrings.selectCategory,
                  bodyMargin: Dimens.halfBodyMargin),

              const SizedBox(height: 25),
              const Padding(
                padding: EdgeInsets.all(8.0),
                // child: tags(textTheme),
              ),
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
        itemCount: manageArticleController.tagList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              var tagId = manageArticleController.tagList[index].id!;
              await Get.find<ListArticleController>()
                  .getArticleListWithTagsId(tagId);
              Get.to(() => ArticleListScreen());
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
                        manageArticleController.tagList[index].title!,
                        style: textTheme.titleSmall!
                            .copyWith(color: SolidColors.hashTag),
                      )),
                )),
          );
        },
      ),
    );
  }
}
