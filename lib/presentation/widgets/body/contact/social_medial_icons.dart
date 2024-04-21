import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:universal_html/html.dart' as html;

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/social_links.dart';

class SocialMediaIcons extends StatelessWidget {
  const SocialMediaIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      children: [
        SocialMediaIconBtn(
          icon: FontAwesomeIcons.github,
          link: SocialLinks.github,
        ),
        SocialMediaIconBtn(
          icon: FontAwesomeIcons.linkedinIn,
          link: SocialLinks.linkedin,
        ),
        SocialMediaIconBtn(
          icon: FontAwesomeIcons.facebook,
          link: SocialLinks.facebook,
        ),
        SocialMediaIconBtn(
          icon: FontAwesomeIcons.instagram,
          link: SocialLinks.instagram,
        ),
        SocialMediaIconBtn(
          icon: FontAwesomeIcons.twitter,
          link: SocialLinks.twitter,
        ),
      ],
    );
  }
}

class SocialMediaIconBtn extends StatefulWidget {
  const SocialMediaIconBtn({super.key, required this.icon, this.link});
  final IconData icon;
  final String? link;

  @override
  State<SocialMediaIconBtn> createState() => _SocialMediaIconBtnState();
}

class _SocialMediaIconBtnState extends State<SocialMediaIconBtn> {
  Color itemColor = AppColors.primaryColor;
  Color bgColor = AppColors.transparent;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _onEnter,
      onExit: _onExit,
      child: TextButton(
        style: IconButton.styleFrom(
          backgroundColor: bgColor,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(15),
        ),
        onPressed: () {
          html.window.open(widget.link!, '_blank');
        },
        child: Icon(
          widget.icon,
          color: itemColor,
          size: 32,
        ),
      ),
    );
  }

  void _onExit(event) {
    setState(() {
      bgColor = AppColors.transparent;
      itemColor = AppColors.primaryColor;
    });
  }

  void _onEnter(event) {
    setState(() {
      bgColor = AppColors.primaryColor;
      itemColor = AppColors.white;
    });
  }
}
