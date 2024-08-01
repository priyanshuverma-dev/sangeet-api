import 'package:sangeet_api/common/models/download_url_model.dart';

class SearchSongModel {
  final String id;
  final String title;
  final String subtitle;
  final String type;
  final List<DownloadUrl> images;
  final bool explicitContent;

  SearchSongModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.images,
    required this.explicitContent,
  });

  factory SearchSongModel.fromMap(Map<String, dynamic> map) {
    return SearchSongModel(
      id: map['id'],
      title: map['title'],
      subtitle: map['subtitle'],
      type: map['type'],
      images: DownloadUrl.imagesUrls(map['image']),
      explicitContent: map['explicit_content'] == '1',
    );
  }
}
