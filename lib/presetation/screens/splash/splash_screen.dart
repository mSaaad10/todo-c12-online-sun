import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_app_c12_online_sun/core/utils/assets_manager.dart';
import 'package:todo_app_c12_online_sun/core/utils/colors_manager.dart';
import 'package:todo_app_c12_online_sun/core/utils/routes_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () {
        Navigator.pushReplacementNamed(context, RoutesManager.home);
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant SplashScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: ColorsManager.scaffoldBg,
        child: Column(
          children: [
            Expanded(
                flex: 3,
                child: Image.asset(
                  AssetsManager.splashLogo,
                  width: 189,
                  height: 211,
                )),
            Expanded(flex: 1, child: Image.asset(AssetsManager.routeLogo)),
          ],
        ));
  }
}
