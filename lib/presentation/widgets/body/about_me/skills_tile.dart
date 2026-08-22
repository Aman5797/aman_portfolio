import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:universal_html/html.dart' as html;

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../data/models/skill.dart';

class SkillTile extends StatefulWidget {
  const SkillTile(this.skill, {super.key});

  final Skill skill;

  @override
  State<SkillTile> createState() => _SkillTileState();
}

class _SkillTileState extends State<SkillTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _borderColorAnim;
  late Animation<Color?> _iconColorAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _borderColorAnim = ColorTween(
      begin: AppColors.white.withValues(alpha: 0.4),
      end: AppColors.primaryColor,
    ).animate(_controller);
    _iconColorAnim = ColorTween(
      begin: AppColors.white,
      end: AppColors.primaryColor,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final borderColor = _borderColorAnim.value ?? AppColors.white;
          final iconColor = _iconColorAnim.value ?? AppColors.white;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: borderColor, width: 1.5),
              borderRadius: BorderRadius.circular(12),
              color: AppColors.primaryLight.withValues(
                alpha: _controller.value * 0.3,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildIcon(iconColor),
                const SizedBox(width: 8),
                Text(
                  widget.skill.name,
                  style: AppStyles.s14.copyWith(color: iconColor),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildIcon(Color color) {
    if (widget.skill.hasNetworkIcon) {
      return _SafeSvgIcon(url: widget.skill.iconUrl, color: color);
    } else if (widget.skill.hasFaIcon) {
      return FaIcon(widget.skill.faIconData!, size: 16, color: color);
    } else if (widget.skill.hasMaterialIcon) {
      return Icon(widget.skill.materialIconData!, size: 18, color: color);
    }
    return const SizedBox.shrink();
  }
}

/// Fetches the SVG via a [Future] first so we can catch 404s / invalid data
/// before handing it to [SvgPicture.network], which would otherwise throw an
/// uncaught "Invalid SVG data" error in the browser console.
class _SafeSvgIcon extends StatefulWidget {
  const _SafeSvgIcon({required this.url, required this.color});
  final String url;
  final Color color;

  @override
  State<_SafeSvgIcon> createState() => _SafeSvgIconState();
}

class _SafeSvgIconState extends State<_SafeSvgIcon> {
  late Future<bool> _svgFetchFuture;

  @override
  void initState() {
    super.initState();
    _svgFetchFuture = _checkSvgValid(widget.url);
  }

  @override
  void didUpdateWidget(_SafeSvgIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url) {
      _svgFetchFuture = _checkSvgValid(widget.url);
    }
  }

  /// Returns true if the URL responds with what looks like valid SVG content.
  Future<bool> _checkSvgValid(String url) async {
    try {
      final dynamic response = await html.window.fetch(url);
      final bool ok = response.ok as bool? ?? false;
      if (!ok) return false;
      final String text = await response.text() as String? ?? '';
      return text.trimLeft().startsWith('<');
    } catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _svgFetchFuture,
      builder: (context, snapshot) {
        // Show spinner while validating
        if (snapshot.connectionState != ConnectionState.done) {
          return SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 1.5,
              color: widget.color.withValues(alpha: 0.4),
            ),
          );
        }
        // Fallback icon if SVG is invalid/missing
        if (snapshot.data != true) {
          return Icon(Icons.code_rounded, size: 18, color: widget.color);
        }
        // Safe to render
        return SvgPicture.network(
          widget.url,
          width: 18,
          height: 18,
          colorFilter: ColorFilter.mode(widget.color, BlendMode.srcIn),
          placeholderBuilder: (_) => const SizedBox(width: 18, height: 18),
        );
      },
    );
  }
}
