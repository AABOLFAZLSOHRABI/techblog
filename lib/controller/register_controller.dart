import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:techblog/constant/my_colors.dart';
import 'package:techblog/constant/my_strings.dart';
import 'package:techblog/constant/storage_const.dart';
import 'package:techblog/gen/assets.gen.dart';
import 'package:techblog/main.dart';
import 'package:techblog/view/main_screen/main_screen.dart';
import 'package:techblog/view/register/register_intro.dart';
import '../constant/api_constant.dart';
import '../services/dio_service.dart';

class RegisterController extends GetxController {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController activeCodeEditingController = TextEditingController();
  var email = '';
  var userId = '';

  register() async {
    Map<String, dynamic> map = {
      'email': emailTextEditingController.text,
      'command': 'register',
    };
    var response = await DioService().postMethod(map, ApiConstant.postRegister);
    email = emailTextEditingController.text;
    userId = response.data["user_id"];
    debugPrint(response.toString());
  }

  verify() async {
    Map<String, dynamic> map = {
      'email': email,
      'user_id': userId,
      'code': activeCodeEditingController.text,
      'command': 'verify',
    };
    var response = await DioService().postMethod(map, ApiConstant.postRegister);
    debugPrint(response.data.toString());
    var status = response.data["response"];
    switch (status) {
      case "verified":
        var box = GetStorage();
        box.write(StorageKey.token, response.data["token"]);
        box.write(StorageKey.userId, response.data["user_id"]);
        debugPrint("read::: ${box.read(StorageKey.token)}");
        debugPrint("read::: ${box.read(StorageKey.userId)}");
        Get.offAll(() => MainScreen());
        break;
      case "incorrect_code":
        Get.snackbar(
          "خطا",
          "کد فعالسازی اشتباه است",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          margin: const EdgeInsets.all(15),
          colorText: Colors.white,
          forwardAnimationCurve: Curves.easeOutBack,
        );
        break;
      case "expired":
        Get.snackbar(
          "خطا",
          "کد فعالسازی منقضی شده است",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          margin: const EdgeInsets.all(15),
          colorText: Colors.white,
          forwardAnimationCurve: Curves.easeOutBack,
        );
        break;
    }
  }

  toggleLogin() {
    if (GetStorage().read(StorageKey.token) == null) {
      Get.to(() => RegisterIntro());
    } else {
      routeToWriteBottomShit();
    }
  }
}

routeToWriteBottomShit() {
  Get.bottomSheet(Container(
    height: Get.height / 3,
    decoration: const BoxDecoration(
        color: SolidColors.scaffoldBg,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(Assets.images.tcbot.path, height: 40),
              const SizedBox(width: 16),
              Text(MyStrings.shareKnowledge,
                  style: const TextStyle(color: SolidColors.textTitle)),
            ],
          ),
          const SizedBox(height: 16),
          Text(MyStrings.gigTech,
              style: const TextStyle(color: SolidColors.textTitle)),
          const SizedBox(height: 34),

          //...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                  onTap: () {
                    Get.toNamed(NamedRoute.routeManageArticle);
                  },
                  child: Row(
                    children: [
                      Image.asset(Assets.icons.writeArticle.path, height: 32),
                      const SizedBox(width: 8),
                      Text(MyStrings.titleAppBarManageArticle,
                          style: const TextStyle(color: SolidColors.textTitle)),
                    ],
                  ),
                ),
              InkWell(
                onTap: () {
                  debugPrint("write podcast");
                },
                child: Row(
                  children: [
                    Image.asset(Assets.icons.writePodcastIcon.path, height: 32),
                    const SizedBox(width: 8),
                    Text(MyStrings.ManagePodcast,
                        style: const TextStyle(color: SolidColors.textTitle)),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    ),
  ));
}
