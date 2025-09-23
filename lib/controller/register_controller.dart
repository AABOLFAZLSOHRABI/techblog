import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:techblog/component/storage_const.dart';
import 'package:techblog/view/main_screen/main_screen.dart';
import 'package:techblog/view/register/register_intro.dart';
import '../component/api_constant.dart';
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

    if (response.data["response"] == 'verified') {
      var box = GetStorage();
      box.write(token, response.data["token"]);
      box.write(userId, response.data["user_id"]);
      debugPrint("read::: ${box.read(token)}");
      debugPrint("read::: ${box.read(userId)}");
      Get.to(()=>MainScreen());
    }else{
      debugPrint("error");
    }
  }
  toggleLogin(){
    if(GetStorage().read(token)==null){
      Get.to(()=>RegisterIntro());
    }else{
      debugPrint('post screen');
    }
  }
}
