import 'package:flutter/material.dart';

import '../../../../core/utils/app_enums.dart';
import '../../../../core/utils/app_extensions.dart';
import 'contact_form.dart';
import 'contact_intro.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = context.width > DeviceType.ipad.getMaxWidth();
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: isDesktop
          ? const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: ContactIntro(),
                ),
                SizedBox(width: 48),
                Expanded(
                  flex: 6,
                  child: ContactForm(),
                ),
              ],
            )
          : const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ContactIntro(),
                SizedBox(height: 36),
                ContactForm(),
              ],
            ),
    );
  }
}
