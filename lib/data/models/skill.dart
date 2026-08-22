import 'package:flutter/material.dart';

class Skill {
  final String name;

  /// Simple Icons CDN slug (e.g., 'flutter', 'firebase').
  /// Icon is fetched from https://cdn.simpleicons.org/{iconSlug}/ffffff
  final String? iconSlug;

  /// FontAwesome icon data — render with FaIcon
  final IconData? faIconData;

  /// Material icon data — render with Icon
  final IconData? materialIconData;

  const Skill({
    required this.name,
    this.iconSlug,
    this.faIconData,
    this.materialIconData,
  });

  String get iconUrl => 'https://cdn.simpleicons.org/$iconSlug/ffffff';

  bool get hasNetworkIcon => iconSlug != null;
  bool get hasFaIcon => faIconData != null;
  bool get hasMaterialIcon => materialIconData != null;
  bool get hasAnyIcon => hasNetworkIcon || hasFaIcon || hasMaterialIcon;
}
