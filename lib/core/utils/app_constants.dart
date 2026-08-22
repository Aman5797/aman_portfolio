import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../data/models/project.dart';
import '../../data/models/skill.dart';
import 'app_assets.dart';

abstract class AppConstants {
  static const double appBarHeight = 80;
  static const List<Skill> skills = [
    // --- Mobile Development ---
    Skill(name: 'Flutter', iconSlug: 'flutter'),
    Skill(name: 'Dart', iconSlug: 'dart'),
    Skill(name: 'Swift', iconSlug: 'swift'),
    Skill(name: 'SwiftUI', iconSlug: 'swift'),
    Skill(name: 'BLoC', faIconData: FontAwesomeIcons.layerGroup),
    Skill(name: 'Provider', faIconData: FontAwesomeIcons.codeBranch),
    Skill(name: 'MVVM', faIconData: FontAwesomeIcons.sitemap),
    Skill(name: 'Clean Architecture', faIconData: FontAwesomeIcons.cubes),
    Skill(name: 'Google ML Kit', iconSlug: 'google'),
    Skill(name: 'Cross-Platform', materialIconData: Icons.devices),
    Skill(name: 'Performance Optimization', materialIconData: Icons.speed),
    Skill(name: 'Audio & Video Players', faIconData: FontAwesomeIcons.play),
    // --- Backend & APIs ---
    Skill(name: 'REST APIs', faIconData: FontAwesomeIcons.plug),
    Skill(name: 'GraphQL', iconSlug: 'graphql'),
    Skill(name: 'SQLite', iconSlug: 'sqlite'),
    Skill(name: 'Firebase', iconSlug: 'firebase'),
    Skill(name: 'JSON Parsing', faIconData: FontAwesomeIcons.fileCode),
    // --- Dev Tools ---
    Skill(name: 'Android Studio', iconSlug: 'androidstudio'),
    Skill(name: 'Xcode', iconSlug: 'xcode'),
    Skill(name: 'Git & GitHub', iconSlug: 'git'),
    Skill(name: 'Postman', iconSlug: 'postman'),
    Skill(name: 'CI/CD (Codemagic)', faIconData: FontAwesomeIcons.gears),
    // --- Auth & Payments ---
    Skill(name: 'Firebase Auth', iconSlug: 'firebase'),
    Skill(name: 'AWS Cognito', faIconData: FontAwesomeIcons.aws),
    Skill(name: 'Stripe', iconSlug: 'stripe'),
    Skill(name: 'Razorpay', iconSlug: 'razorpay'),
    Skill(name: 'In-App Purchases', iconSlug: 'apple'),
    Skill(
      name: 'Push Notifications',
      faIconData: FontAwesomeIcons.bell,
    ),
    // --- AI / LLM ---
    Skill(name: 'GitHub Copilot', iconSlug: 'github'),
    Skill(name: 'AI-Assisted Dev', faIconData: FontAwesomeIcons.robot),
  ];

  static const List<Project> projects = [
    Project(
      name: 'Hotelogix',
      imagePath: AppAssets.hotelogixLogo,
      description:
          'Hotel management mobile app used by 1000+ hotels. Improved check-in efficiency by 30% with OCR, credit card scanning, biometric login, and instant printing. 99.9% crash-free sessions.',
      iosApp:
          'https://apps.apple.com/in/app/hotelogix-mobile-hotel/id1194551150',
      googlePlay:
          'https://play.google.com/store/apps/details?id=com.pocketpms.app&hl=en_IN',
      techTags: ['Flutter', 'Dart', 'OCR', 'Biometrics', 'BLoC', 'REST API'],
    ),
    Project(
      name: 'Dwellspring',
      imagePath: AppAssets.dwellLogo,
      description:
          'Custom sound mixer with ambient, noise, and user-recorded audio. Features offline playback, timers, alarms, multiplayer audio engine, and in-app purchases for a meditation & sleep experience.',
      iosApp:
          "https://apps.apple.com/us/app/dwellspring-sleep-sounds/id6479635936",
      googlePlay:
          'https://play.google.com/store/apps/details?id=com.dwell_spring.client',
      techTags: ['Flutter', 'Audio Engine', 'In-App Purchases', 'BLoC', 'SQLite'],
    ),
    Project(
      name: 'Reel Media: Fan App',
      imagePath: AppAssets.reelLogo,
      description:
          'Multifunctional event platform with ticket purchases, QR scanning, Stripe payments, ticket PDFs, and biometric authentication for secure event access.',
      techTags: ['Flutter', 'Stripe', 'QR Scanner', 'Biometrics', 'PDF Gen'],
    ),
    Project(
      name: 'Rise',
      imagePath: AppAssets.riseLogo,
      description:
          'Social media app for sharing health awareness posts, stories, and reels. Features one-to-one chat and community-driven content sharing.',
      iosApp: "https://www.risehealth.world/",
      googlePlay: "https://www.risehealth.world/",
      techTags: ['Flutter', 'Firebase', 'Chat Engine', 'Video Player', 'AWS'],
    ),
    Project(
      name: 'Pace: HSE',
      imagePath: AppAssets.paceLogo,
      description:
          'Safety management app enabling real-time safety audits, incident recording, and compliance monitoring for enterprise clients.',
      iosApp: 'https://apps.apple.com/us/app/pace-hse/id1549816913',
      googlePlay:
          'https://play.google.com/store/apps/details?id=com.teknobuilt.pace_hse',
      techTags: ['Flutter', 'Auditing', 'Enterprise', 'Offline Sync', 'REST API'],
    ),
    Project(
      name: 'Apex Predator Explorer',
      imagePath: AppAssets.apexLogo,
      description:
          'Native iOS app built with SwiftUI & MVVM featuring dynamic List, NavigationStack, search filtering, animations, and REST API integration with Codable JSON parsing.',
      techTags: ['Swift', 'SwiftUI', 'MVVM', 'NavigationStack', 'Codable'],
    ),
  ];
}
