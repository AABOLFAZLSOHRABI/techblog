// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'gen/assets.gen.dart';
import 'models/fake_data.dart';
import 'my_colors.dart';
// import 'my_colors.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    double bodyMargin = size.width/10;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(Icons.menu),
                  Image.asset(Assets.images.logo.path,
                      width: size.height / 13.6),
                  const Icon(Icons.search)
                ],
              ),
              const SizedBox(width: 8),
              Stack(
                children: [
                  Container(
                      width: size.width / 1.25,
                      height: size.height / 4.2,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        image: DecorationImage(
                          image: AssetImage(HomePagePosterMap["imageAsset"]),
                          fit: BoxFit.cover,
                        ),
                      ),
                      foregroundDecoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        gradient: LinearGradient(
                          colors: GradientColors.homePosterCoverGradiant,
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      )),
                  Positioned(
                    bottom: 8,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                                HomePagePosterMap["writer"] +
                                    " - " +
                                    HomePagePosterMap["data"],
                                style: textTheme.bodyMedium),
                            Row(
                              children: [
                                Text(HomePagePosterMap["views"],
                                    style: textTheme.bodyMedium),
                                const SizedBox(width: 4),
                                const Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(HomePagePosterMap["title"],
                            style: textTheme.bodyLarge),
                      ],
                    ),
                  )
                ],
              ),
              // tag list
              const SizedBox(height: 16),
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tagList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:EdgeInsets.fromLTRB(0, 8,index==0?bodyMargin:15, 8),
                      child: Container(

                        height: 60,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                          gradient: LinearGradient(
                              colors: GradientColors.tags,
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Row(
                            children: [
                              ImageIcon(
                                AssetImage(Assets.icons.hashtagicon.path),
                                color: Colors.white,
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                tagList[index].title,
                                style: textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
