class Project {
  final String name;
  final String imagePath;
  final String description;
  final String? iosApp;
  final String? googlePlay;

  const Project({
    required this.name,
    required this.imagePath,
    required this.description,
    this.iosApp,
    this.googlePlay,
  });
}
