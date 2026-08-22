import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_constants.dart';
import '../../../core/utils/app_extensions.dart';
import '../../../core/widgets/scroll_controller_provider.dart';
import '../../blocs/home_bloc/home_bloc.dart';
import '../app_bar/vertical_headers_builder.dart';
import 'about_me/about_me_section.dart';
import 'contact/contact_section.dart';
import 'footer_section.dart';
import 'intro/intro_section.dart';
import 'projects/projects_section.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> with TickerProviderStateMixin {
  final ScrollController _controller = ScrollController();
  final introKey = GlobalKey();
  final aboutKey = GlobalKey();
  final projectKey = GlobalKey();
  final contactKey = GlobalKey();

  // Blob animation
  late AnimationController _blobController;
  late Animation<double> _blobAnim;

  @override
  void initState() {
    super.initState();
    _blobController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);
    _blobAnim =
        CurvedAnimation(parent: _blobController, curve: Curves.easeInOut);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initListenerForInteractWithHeaderIndex();
    });
  }

  void _initListenerForInteractWithHeaderIndex() {
    double introHeight = introKey.currentContext!.size!.height;
    double aboutHeight = aboutKey.currentContext!.size!.height;
    double projectHeight = projectKey.currentContext!.size!.height;
    _controller.addListener(() {
      double offset = _controller.offset;
      if (_controller.position.extentAfter == 0.0) {
        context.read<HomeBloc>().add(ChangeAppBarHeadersColorByColor(3));
      } else if (offset < introHeight) {
        context.read<HomeBloc>().add(ChangeAppBarHeadersColorByColor(0));
      } else if (offset < (introHeight + aboutHeight)) {
        context.read<HomeBloc>().add(ChangeAppBarHeadersColorByColor(1));
      } else if (offset < (introHeight + aboutHeight + projectHeight)) {
        context.read<HomeBloc>().add(ChangeAppBarHeadersColorByColor(2));
      } else {
        context.read<HomeBloc>().add(ChangeAppBarHeadersColorByColor(3));
      }
    });
  }

  @override
  void dispose() {
    _blobController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hPad = context.width * .08;
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is AppBarHeadersIndexChanged) {
          Navigator.of(context).maybePop();
          const duration = Duration(milliseconds: 500);
          final keys = [introKey, aboutKey, projectKey, contactKey];
          if (state.index < keys.length) {
            Scrollable.ensureVisible(
              keys[state.index].currentContext!,
              duration: duration,
              curve: Curves.easeInOut,
              alignment: 0.0,
            );
          }
        }
      },
      child: ScrollControllerProvider(
        controller: _controller,
        child: Stack(
          children: [
            // ── Animated background blobs ────────────────────────────
            _BackgroundBlobs(animation: _blobAnim),

            // ── Main scrollable content ──────────────────────────────
            SingleChildScrollView(
              controller: _controller,
              padding: EdgeInsets.symmetric(horizontal: hPad),
              child: Column(
                children: [
                  // Top padding for the floating app bar
                  SizedBox(height: AppConstants.appBarHeight.toDouble()),
                  IntroSection(key: introKey),
                  AboutMeSection(key: aboutKey),
                  ProjectsSection(key: projectKey),
                  ContactSection(key: contactKey),
                  const FooterSection(),
                ],
              ),
            ),

            const VerticalHeadersBuilder(),
          ],
        ),
      ),
    );
  }
}

/// Three animated gradient blobs that give the page a living, premium feel.
class _BackgroundBlobs extends StatelessWidget {
  const _BackgroundBlobs({required this.animation});
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final w = context.width;
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final t = animation.value;
        return Stack(
          children: [
            // Blob 1 — top right violet
            Positioned(
              top: -120 + t * 30,
              right: -80 + t * 20,
              child: _blob(w * .55, const Color(0x1A7C3AED)),
            ),
            // Blob 2 — left side cyan
            Positioned(
              top: 300 - t * 40,
              left: -100 + t * 15,
              child: _blob(w * .40, const Color(0x1006B6D4)),
            ),
            // Blob 3 — center bottom
            Positioned(
              top: 700 + t * 50,
              right: w * .2,
              child: _blob(w * .35, const Color(0x153B82F6)),
            ),
          ],
        );
      },
    );
  }

  Widget _blob(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, const Color(0x00000000)],
          radius: 0.7,
        ),
      ),
    );
  }
}
