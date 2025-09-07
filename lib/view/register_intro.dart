import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:techblog/my_colors.dart';
import 'package:techblog/my_strings.dart';

import '../gen/assets.gen.dart';

class RegisterIntro extends StatelessWidget {
  const RegisterIntro({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    // var size = MediaQuery.of(context).size;
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
                  style: ButtonStyle(
                    textStyle: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.pressed)) {
                        return textTheme.headlineSmall;
                      } else {
                        return textTheme.titleLarge;
                      }
                    }),
                    backgroundColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.pressed)) {
                        return SolidColors.posterTitle;
                      } else {
                        return SolidColors.primaryColor;
                      }
                    }),
                    foregroundColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.pressed)) {
                        return SolidColors.primaryColor;
                      } else {
                        return SolidColors.posterTitle;
                      }
                    }),
                  ),
                  onPressed: () {},
                  child: Text(
                    MyStrings.letsGo,
                  )),
            )
          ],
        ),
      ),
    ));
  }
}
