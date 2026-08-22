import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:universal_html/html.dart' as html;

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../data/models/project.dart';

class ProjectItem extends StatefulWidget {
  const ProjectItem({super.key, required this.project, this.index = 0});

  final Project project;
  final int index;

  @override
  State<ProjectItem> createState() => _ProjectItemState();
}

class _ProjectItemState extends State<ProjectItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        transform: _isHovered
            ? (Matrix4.identity()..translate(0, -6, 0))
            : Matrix4.identity(),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _isHovered
              ? AppColors.cardColor.withValues(alpha: 0.9)
              : AppColors.glassBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered
                ? AppColors.primaryColor.withValues(alpha: 0.8)
                : AppColors.glassBorder,
            width: _isHovered ? 1.5 : 1.0,
          ),
          boxShadow: [
            if (_isHovered)
              BoxShadow(
                color: AppColors.primaryColor.withValues(alpha: 0.25),
                blurRadius: 30,
                spreadRadius: 2,
                offset: const Offset(0, 10),
              )
            else
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Bar: Project Index + Logo Image + Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Project Logo inside a stylized container
                Container(
                  width: 48,
                  height: 48,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.scaffoldColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.glassBorder,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.asset(
                      project.imagePath,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                // Links (iOS / Android / GitHub)
                Row(
                  children: [
                    if (project.iosApp != null)
                      _IconButton(
                        icon: FontAwesomeIcons.apple,
                        tooltip: 'App Store',
                        onTap: () => html.window.open(project.iosApp!, '_blank'),
                      ),
                    if (project.googlePlay != null) ...[
                      const SizedBox(width: 8),
                      _IconButton(
                        icon: FontAwesomeIcons.googlePlay,
                        tooltip: 'Google Play',
                        onTap: () =>
                            html.window.open(project.googlePlay!, '_blank'),
                      ),
                    ],
                    if (project.githubLink != null) ...[
                      const SizedBox(width: 8),
                      _IconButton(
                        icon: FontAwesomeIcons.github,
                        tooltip: 'GitHub',
                        onTap: () =>
                            html.window.open(project.githubLink!, '_blank'),
                      ),
                    ],
                  ],
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Project Title
            Text(
              project.name,
              style: AppStyles.s20.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),

            // Project Description
            Expanded(
              child: Text(
                project.description,
                style: AppStyles.s14.copyWith(
                  color: AppColors.lightColor.withValues(alpha: 0.9),
                  height: 1.5,
                ),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 12),

            // Tech Tags
            if (project.techTags.isNotEmpty)
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: project.techTags.map((tag) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: AppColors.primaryColor.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Text(
                      tag,
                      style: AppStyles.s12.copyWith(
                        color: AppColors.secondaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}

class _IconButton extends StatefulWidget {
  const _IconButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  @override
  State<_IconButton> createState() => _IconButtonState();
}

class _IconButtonState extends State<_IconButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: Tooltip(
        message: widget.tooltip,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _isHovered
                  ? AppColors.primaryColor.withValues(alpha: 0.2)
                  : AppColors.glassBg,
              shape: BoxShape.circle,
              border: Border.all(
                color: _isHovered
                    ? AppColors.primaryColor
                    : AppColors.glassBorder,
              ),
            ),
            child: FaIcon(
              widget.icon,
              size: 16,
              color: _isHovered ? AppColors.primaryColor : AppColors.lightColor,
            ),
          ),
        ),
      ),
    );
  }
}
