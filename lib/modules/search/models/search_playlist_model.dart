import 'package:sangeet_api/common/models/download_url_model.dart';

class SearchPlaylistModel {
  final String id;
  final String title;
  final String subtitle;
  final String type;
  final List<DownloadUrl> images;
  final String language;
  final bool explicitContent;
  final String description;
  final List<String> artistName;

  SearchPlaylistModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.images,
    required this.language,
    required this.explicitContent,
    required this.description,
    required this.artistName,
  });

  factory SearchPlaylistModel.fromMap(Map<String, dynamic> map) {
    return SearchPlaylistModel(
      id: map['id'],
      title: map['title'],
      subtitle: map['subtitle'],
      type: map['type'],
      images: DownloadUrl.imagesUrls(map['image']),
      explicitContent: map['explicit_content'] == '1',
      description: map['description'],
      language: map['more_info']['language'],
      artistName: List<String>.from(
        map['more_info']['artist_name'].map((e) => e),
      ),
    );
  }
}
