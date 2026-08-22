import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_enums.dart';
import '../../../core/utils/app_extensions.dart';
import '../../../core/utils/app_styles.dart';
import '../../blocs/home_bloc/home_bloc.dart';

class CustomHeaderBtn extends StatefulWidget {
  const CustomHeaderBtn({super.key, required this.headerIndex, this.onTap});

  final int headerIndex;
  final VoidCallback? onTap;

  @override
  State<CustomHeaderBtn> createState() => _CustomHeaderBtnState();
}

class _CustomHeaderBtnState extends State<CustomHeaderBtn>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _underlineWidth;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _underlineWidth = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _isActive =>
      context.read<HomeBloc>().appBarHeaderIndex == widget.headerIndex;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final isActive = _isActive;
        if (isActive || _isHovered) {
          _controller.forward();
        } else {
          _controller.reverse();
        }

        return MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              context
                  .read<HomeBloc>()
                  .add(ChangeAppBarHeadersIndex(widget.headerIndex));
              widget.onTap?.call();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppBarHeaders.values[widget.headerIndex].getString(),
                    style: AppStyles.s16.copyWith(
                      color: isActive
                          ? AppColors.white
                          : AppColors.lightColor.withValues(alpha: 0.75),
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 4),
                  AnimatedBuilder(
                    animation: _underlineWidth,
                    builder: (context, _) {
                      return LayoutBuilder(builder: (context, constraints) {
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: ShaderMask(
                            blendMode: BlendMode.srcIn,
                            shaderCallback: (bounds) =>
                                AppColors.accentGradientHoriz.createShader(
                              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                            ),
                            child: Container(
                              width: 40 * _underlineWidth.value,
                              height: 2,
                              color: AppColors.white,
                            ),
                          ),
                        );
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
