import 'package:flutter/material.dart';
import 'package:techblog/constant/my_strings.dart';

import '../../gen/assets.gen.dart';
import '../../constant/my_colors.dart';
import '../../component/my_component.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.size,
    required this.textTheme,
  });

  final Size size;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(children: [
            Image(
              image: Assets.images.profileAvatar.provider(),
              height: 100,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageIcon(Assets.icons.bluePen.provider(),
                    color: SolidColors.seeMore),
                const SizedBox(width: 15),
                Text(MyStrings.imageProfileEdit,
                    style: textTheme.bodyLarge!
                        .copyWith(color: SolidColors.seeMore)),
              ],
            ),
            const SizedBox(height: 60),
            Text("سورنا ساسانی",
                style: textTheme.headlineMedium!
                    .copyWith(color: SolidColors.primaryColor)),
            Text("Sorena@gmail.com",
                style:
                    textTheme.bodyLarge!.copyWith(color: SolidColors.textTitle)),
            const SizedBox(height: 40),
            TechDivider(size: size),
            InkWell(
              onTap: () {},
              splashColor: SolidColors.primaryColor,
              child: SizedBox(
                height: 45,
                child:
                Center(
                  child: Text(
                    MyStrings.myFavBlog,
                    style: textTheme.bodyLarge!
                        .copyWith(color: SolidColors.textTitle),
                  ),
                ),
              ),
            ),
            TechDivider(size: size),
            InkWell(
              onTap: () {},
              splashColor: SolidColors.primaryColor,
              child: SizedBox(
                height: 45,
                child:
                Center(
                  child: Text(
                    MyStrings.myFavPodcast,
                    style: textTheme.bodyLarge!
                        .copyWith(color: SolidColors.textTitle),
                  ),
                ),
              ),
            ),
            TechDivider(size: size),
            InkWell(
              onTap: () {},
              splashColor: SolidColors.primaryColor,
              child: SizedBox(
                height: 45,
                child:
                Center(
                  child: Text(
                    MyStrings.logOut,
                    style: textTheme.bodyLarge!
                        .copyWith(color: SolidColors.textTitle),
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height / 10),
          ])),
    );
  }
}
