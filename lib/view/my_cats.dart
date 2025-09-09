import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techblog/gen/assets.gen.dart';
import 'package:techblog/my_strings.dart';

import '../models/fake_data.dart';
import '../my_colors.dart';
import '../my_component.dart';
// import '../my_component.dart';

class MyCats extends StatefulWidget {
  const MyCats({super.key});

  @override
  State<MyCats> createState() => _MyCatsState();
}

class _MyCatsState extends State<MyCats> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    double bodyMargin = size.width / 10;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(left: bodyMargin, right: bodyMargin),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 64),
                SvgPicture.asset(Assets.images.tcbot.path, height: 100),
                const SizedBox(height: 32),
                Text(MyStrings.successfulRegistration,
                    style: textTheme.titleLarge),
                const SizedBox(height: 16),
                TextField(
                  style: TextStyle(
                      color: SolidColors.textTitle,
                      fontSize: textTheme.bodyLarge!.fontSize),
                  decoration: InputDecoration(
                    hintText: MyStrings.nameAndFamilyName,
                    hintStyle: textTheme.bodyLarge!.copyWith(
                      color: SolidColors.hintText,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Text(MyStrings.chooseCats, style: textTheme.titleLarge),
                // tage list
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: SizedBox(
                    height: 85,
                    width: double.infinity,
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: tagList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 120,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              setState(() {
                                if (!selectedTags.contains(tagList[index])){
                                  selectedTags.add(tagList[index]);
                                }else{
                                  return;
                                }
                              });
                            },
                            child:
                                MainTags(textTheme: textTheme, index: index));
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Image.asset(Assets.icons.downCatArrow.path, scale: 3),
                const SizedBox(height: 16),
                // tage list *SELECT*
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: SizedBox(
                    height: 85,
                    width: double.infinity,
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: selectedTags.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 150,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          height: 60,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                            color: SolidColors.surface,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(width: 8),
                                Text(
                                  selectedTags[index].title,
                                  style: textTheme.bodyMedium!
                                      .copyWith(color: SolidColors.textTitle),
                                ),
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedTags.removeAt(index);
                                      });
                                    },
                                    child: const Icon(
                                      CupertinoIcons.delete_solid,
                                      color: SolidColors.erorColor,
                                      size: 20,
                                    ))
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
      ),
    ));
  }
}
