import '../../data/models/project.dart';
import 'app_assets.dart';

abstract class AppConstants {
  static const double appBarHeight = 80;
  static const List<String> skills = [
    'Flutter',
    'Dart',
    'SQLite',
    'BLoc',
    'Provider',
    'Clean Architecture',
    'XCode',
    'Android Studio',
    'App Deployment',
    'Version control with GIT',
    'REST API consumption',
    'Firebase',
    'Analytics and Crashlytics',
    'Push Notification Services',
    'Payment Gateway',
    'Inapp-Purchase',
    'Data structures and algorithms',
  ];
  static const List<Project> projects = [
    Project(
      name: 'Dwellspring',
      imagePath: AppAssets.dwellLogo,
      description:
          'An app where users can create unique sound mixes and noises by combining multiple audios, record and share content.',
    ),
    Project(
      name: "Rise",
      imagePath: AppAssets.riseLogo,
      description:
          'Social media application for share health awareness posts and stories with people, One-to-one chat, Share reels videos.',
    ),
    Project(
      name: "Reel Media",
      imagePath: AppAssets.reelLogo,
      description:
          'The app is a multifunctional event platform for activities, facilitating ticket purchases, and detailed event statistics.',
    ),
    Project(
      name: "Pace: HSE",
      imagePath: AppAssets.paceLogo,
      description:
          'The app enables safety audits, incident recording, and compliance monitoring in realtime.',
      iosApp: 'https://apps.apple.com/us/app/pace-hse/id1549816913',
      googlePlay:
          'https://play.google.com/store/apps/details?id=com.teknobuilt.pace_hse',
    ),
  ];
}
