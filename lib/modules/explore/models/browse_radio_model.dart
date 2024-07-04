class BrowseRadioModel {
  final String id;
  final String title;
  final String subtitle;
  final String image;
  final String accentColor;
  final String language;
  final String? description;
  final String type;
  final bool explicitContent;

  BrowseRadioModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.accentColor,
    required this.language,
    required this.description,
    required this.type,
    required this.explicitContent,
  });

  factory BrowseRadioModel.fromMap(Map<String, dynamic> map) {
    return BrowseRadioModel(
      id: map['id'],
      title: map['title'],
      subtitle: map['subtitle'],
      image: map['image'],
      accentColor: map['more_info']['color'] ?? "",
      language: map['more_info']['language'],
      description: map['more_info']['description'],
      type: map['type'],
      explicitContent: map['explicit_content'] == '1',
    );
  }
}
