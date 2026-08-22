import 'package:flutter/material.dart';
import '../widgets/body/home_body.dart';
import '../widgets/app_bar/home_app_bar.dart';

/// HomeView uses a Stack so the glassmorphism AppBar can blur the body content
/// behind it. A traditional Scaffold.appBar cannot achieve true BackdropFilter blur
/// because it clips the body at the AppBar boundary.
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          HomeBody(),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: HomeAppBar(),
          ),
        ],
      ),
    );
  }
}
