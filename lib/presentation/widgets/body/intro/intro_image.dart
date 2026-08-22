import 'package:flutter/material.dart';

import 'package:aman_portfolio/core/utils/app_assets.dart';

class IntroImage extends StatelessWidget {
  const IntroImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssets.devImg,
      colorBlendMode: BlendMode.darken,
    );
  }
}
