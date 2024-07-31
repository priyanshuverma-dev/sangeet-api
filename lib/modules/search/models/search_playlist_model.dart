import 'package:sangeet_api/common/models/download_url_model.dart';

class SearchPlaylistModel {
  final String id;
  final String title;
  final String subtitle;
  final String type;
  final List<DownloadUrl> images;
  final bool explicitContent;

  SearchPlaylistModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.images,
    required this.explicitContent,
  });

  factory SearchPlaylistModel.fromMap(Map<String, dynamic> map) {
    return SearchPlaylistModel(
      id: map['id'],
      title: map['title'],
      subtitle: map['subtitle'],
      type: map['type'],
      images: DownloadUrl.imagesUrls(map['image']),
      explicitContent: map['explicit_content'] == '1',
    );
  }
}
