import 'package:sangeet_api/common/models/download_url_model.dart';

class SearchAlbumModel {
  final String id;
  final String title;
  final String? subtitle;
  final bool explicitContent;
  final String type;
  final List<DownloadUrl> images;

  SearchAlbumModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.explicitContent,
    required this.images,
  });

  factory SearchAlbumModel.fromMap(Map<String, dynamic> map) {
    return SearchAlbumModel(
      id: map["id"],
      title: map['title'],
      subtitle: map['more_info']['music'],
      type: map["type"],
      explicitContent: map['explicit_content'] == '1',
      images: DownloadUrl.imagesUrls(map['image']),
    );
  }
}
