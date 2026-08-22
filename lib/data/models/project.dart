class Project {
  final String name;
  final String imagePath;
  final String description;
  final String? iosApp;
  final String? googlePlay;
  final String? githubLink;
  final List<String> techTags;

  const Project({
    required this.name,
    required this.imagePath,
    required this.description,
    this.iosApp,
    this.googlePlay,
    this.githubLink,
    this.techTags = const [],
  });
}
