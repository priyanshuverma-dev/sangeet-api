import 'package:sangeet_api/common/models/download_url_model.dart';

class PlaylistMapModel {
  final String id;
  final String title;
  final String subtitle;
  final String type;
  final List<DownloadUrl> images;
  final String? language;
  final int songCount;
  final bool explicitContent;
  PlaylistMapModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.images,
    required this.language,
    required this.explicitContent,
    required this.songCount,
  });

  factory PlaylistMapModel.fromMap(Map<String, dynamic> map) {
    return PlaylistMapModel(
      id: map['id'],
      title: map['title'],
      subtitle: map['subtitle'],
      type: map['type'],
      images: DownloadUrl.imagesUrls(map['image']),
      explicitContent: map['explicit_content'] == '1',
      language: map['more_info']['language'],
      songCount: int.parse(map['more_info']['song_count']),
    );
  }
}
