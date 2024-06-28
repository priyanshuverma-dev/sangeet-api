class BrowseChannelModel {
  final String id;
  final String title;
  final String type;
  final String image;
  final bool explicitContent;

  BrowseChannelModel({
    required this.id,
    required this.title,
    required this.type,
    required this.image,
    required this.explicitContent,
  });

  factory BrowseChannelModel.fromMap(Map<String, dynamic> map) {
    return BrowseChannelModel(
      id: map['id'],
      title: map['title'],
      type: map['type'],
      image: map['image'],
      explicitContent: map['explicit_content'] == "1",
    );
  }
}
