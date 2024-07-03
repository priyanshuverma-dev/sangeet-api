class MediaModel {
  final String id;
  final String title;
  final String subtitle;
  final String image;
  final String type;
  final bool explicitContent;
  MediaModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.type,
    required this.explicitContent,
  });

  MediaModel copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? image,
    String? type,
    bool? explicitContent,
  }) {
    return MediaModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      image: image ?? this.image,
      explicitContent: explicitContent ?? this.explicitContent,
      type: type ?? this.type,
    );
  }

  factory MediaModel.fromMap(Map<String, dynamic> map) {
    return MediaModel(
      id: map['id'] as String,
      title: map['title'] as String,
      subtitle: map['subtitle'] as String,
      image: map['image'] as String,
      type: map['type'] as String,
      explicitContent: map['explicit_content'] == "1",
    );
  }
}
