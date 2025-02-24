// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'gen/assets.gen.dart';
import 'my_colors.dart';
// import 'my_colors.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
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
                          image:
                              Image.asset(Assets.images.posterTest.path).image,
                          fit: BoxFit.cover,
                        ),
                      ),
                      foregroundDecoration: const BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.circular(16)),
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
                            Text("ابوالفضل - یک روز پیش",style: textTheme.bodyMedium),
                            Text("Like 253",style: textTheme.bodyMedium),
                          ],
                        ),
                        Text("دوازده قدم برنامه نویسی یک دوره ...", style: textTheme.bodyLarge),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
