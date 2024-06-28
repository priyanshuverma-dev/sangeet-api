import 'package:sangeet_api/common/models/download_url_model.dart';

class SearchAlbumModel {
  final String id;
  final String title;
  final String? subtitle;
  final String description;
  final bool explicitContent;
  final String type;
  final List<DownloadUrl> images;
  final String language;
  final String year;
  final String songPids;

  SearchAlbumModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.type,
    required this.explicitContent,
    required this.images,
    required this.language,
    required this.year,
    required this.songPids,
  });

  factory SearchAlbumModel.fromMap(Map<String, dynamic> map) {
    return SearchAlbumModel(
      id: map["id"],
      title: map['title'],
      subtitle: map['more_info']['music'],
      description: map['description'],
      type: map["type"],
      explicitContent: map['explicit_content'] == '1',
      images: DownloadUrl.imagesUrls(map['image']),
      language: map['more_info']['language'],
      year: map['more_info']['year'],
      songPids: map['more_info']['song_pids'],
    );
  }
}
