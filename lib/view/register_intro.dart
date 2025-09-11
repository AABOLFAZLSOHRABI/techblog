import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:techblog/component/my_colors.dart';
import 'package:techblog/component/my_strings.dart';

import '../gen/assets.gen.dart';
import 'my_cats.dart';

class RegisterIntro extends StatelessWidget {
  const RegisterIntro({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.images.tcbot.path,
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 34),
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: MyStrings.welcome,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: SolidColors.textTitle))),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: ElevatedButton(
                  onPressed: () {
                    _buildEmailModalBotSheet(context, size, textTheme);
                  },
                  child: Text(
                    MyStrings.letsGo,
                  )),
            )
          ],
        ),
      ),
    ));
  }

  Future<dynamic> _buildEmailModalBotSheet(
      BuildContext context, Size size, TextTheme textTheme) {
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: size.height / 2,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(MyStrings.insertYourEmail,
                      style: textTheme.titleMedium!
                          .copyWith(color: SolidColors.textTitle)),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 42),
                    child: TextField(
                      onChanged: (value) {},
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: SolidColors.textTitle),
                      decoration: const InputDecoration(
                        hintText: "techblog@support.com",
                        hintStyle: TextStyle(color: SolidColors.hintText),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _activateCodeModalBotSheet(context, size, textTheme);
                      },
                      child: const Text("ادامه"))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Future<dynamic> _activateCodeModalBotSheet(
    BuildContext context, Size size, TextTheme textTheme) {
  return showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: size.height / 2,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(MyStrings.activateCode,
                    style: textTheme.titleMedium!
                        .copyWith(color: SolidColors.textTitle)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 42),
                  child: TextField(
                    onChanged: (value) {},
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: SolidColors.textTitle),
                    decoration: const InputDecoration(
                      hintText: "******",
                      hintStyle: TextStyle(color: SolidColors.hintText),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) =>const MyCats()));
                    },
                    child: const Text("ادامه"))
              ],
            ),
          ),
        ),
      );
    },
  );
}
