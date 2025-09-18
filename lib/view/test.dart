import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techblog/controller/list_article_controller.dart';

import '../component/my_colors.dart';

class Test extends StatelessWidget {
  Test({super.key});
  final textTheme = Get.theme.textTheme;
  final ListArticleController articleController = Get.put(ListArticleController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Obx( () => ListView.builder(
        itemCount: articleController.articleList.length,
        itemBuilder: (context, index) {
          return Text(
            articleController.articleList[index].title!,
            style: textTheme.bodyLarge!
                .copyWith(color: SolidColors.textTitle),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          );
        },),
      ),
    ));
  }
}
