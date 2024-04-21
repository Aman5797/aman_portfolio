import 'package:flutter/material.dart';

class ProjectImage extends StatelessWidget {
  const ProjectImage({super.key, required this.imagePath});
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      fit: FlexFit.tight,
      child: Image.asset(
        imagePath,
        width: double.infinity,
        // fit: BoxFit.cover,
      ),
    );
  }
}
