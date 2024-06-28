class BrowseChartModel {
  final String id;
  final String title;
  final String subtitle;
  final String image;
  final bool explicitContent;
  final String language;

  BrowseChartModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.explicitContent,
    required this.language,
  });

  factory BrowseChartModel.fromMap(Map<String, dynamic> map) {
    return BrowseChartModel(
      id: map['id'],
      title: map['title'],
      subtitle: map['subtitle'],
      image: map['image'],
      explicitContent: map['explicit_content'] == "1",
      language: map['language'],
    );
  }
}
