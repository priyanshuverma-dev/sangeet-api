import 'package:sangeet_api/common/models/download_url_model.dart';

class SearchArtistModel {
  final String id;
  final String title;
  final List<DownloadUrl> images;
  final String type;
  final String description;
  final int position;

  SearchArtistModel({
    required this.id,
    required this.title,
    required this.images,
    required this.type,
    required this.description,
    required this.position,
  });

  factory SearchArtistModel.fromMap(Map<String, dynamic> map) {
    return SearchArtistModel(
      id: map['id'],
      title: map['title'],
      images: DownloadUrl.imagesUrls(map['image']),
      type: map['type'],
      description: map['description'],
      position: map['position'],
    );
  }
}
