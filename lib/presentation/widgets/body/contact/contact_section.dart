import 'package:flutter/material.dart';

import 'contact_intro.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 80),
      child: ContactIntro(),
      // context.width > DeviceType.ipad.getMaxWidth()
      //     ? const Row(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Expanded(
      //             child: ContactIntro(),
      //           ),
      //           SizedBox(width: 32),
      //           Expanded(child: ContactForm()),
      //         ],
      //       )
      //     : const Column(
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         children: [
      //           ContactIntro(),
      //           SizedBox(height: 32),
      //           ContactForm(),
      //         ],
      //       ),
    );
  }
}
