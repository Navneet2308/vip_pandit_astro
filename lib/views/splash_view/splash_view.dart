import 'package:astrologeradmin/constance/assets_path.dart';
import 'package:astrologeradmin/constance/language/language.dart';
import 'package:astrologeradmin/constance/my_colors.dart';
import 'package:astrologeradmin/constance/textstyle.dart';
import 'package:astrologeradmin/provider/splash_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    // Start the navigation after 5 seconds when the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SplashProvider>(context, listen: false)
          .navigateToNextScreen(context);
    });

    return Scaffold(
      backgroundColor: bg,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage(AssetsPath.splashBg)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
                alignment: Alignment.center,
                child: Image.asset(
                  AssetsPath.logo,
                  height: 115,
                  width: 115,
                )),
            Container(
                padding: EdgeInsets.only(top: 15),
                alignment: Alignment.center,
                child: Image.asset(
                  AssetsPath.aiAstrology,
                  height: 62,
                  width: 123,
                ))
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Wrap(
        children: [
          Container(
              color: Colors.transparent,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(bottom: 40),
              child: Text(
                Languages.of(context)!.aiAstrology,
                style: mediumTextStyle(fontSize: dimen14, color: lightText),
              ))
        ],
      ),
    );
  }
}
