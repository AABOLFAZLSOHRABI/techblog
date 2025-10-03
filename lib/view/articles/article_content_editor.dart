import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:techblog/component/my_component.dart';
import 'package:techblog/constant/my_strings.dart';
import 'package:techblog/controller/article/manage_article_controller.dart';

class ArticleContentEditor extends StatelessWidget {
  ArticleContentEditor({super.key});
  final HtmlEditorController controller = HtmlEditorController();
  final manageArticleController = Get.put(ManageArticleController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.clearFocus(),
      child: Scaffold(
        appBar: appBar(MyStrings.titleAppBarArticleContentEditor),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HtmlEditor(controller: controller,
              htmlEditorOptions: HtmlEditorOptions(
                hint: MyStrings.hintArticleContentEditor,
                shouldEnsureVisible: true,
                initialText: manageArticleController.articleInfoModel.value.content ??
                    MyStrings.editOrginalTextArticle,
              ),
                callbacks: Callbacks(onChangeContent: (p0) {
                  manageArticleController.articleInfoModel.update((val) {
                    val!.content = p0;
                  },);
                },),
              )
            ],
          ),
        ),
      ),
    );
  }
}



