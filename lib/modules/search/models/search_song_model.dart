import 'package:sangeet_api/common/models/download_url_model.dart';

class SearchSongModel {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final String type;
  final List<DownloadUrl> images;
  final bool explicitContent;
  final String language;
  final int ctr;
  final String? albumId;
  final String albumName;
  final String singers;
  final String primaryArtists;
  final String permaUrl;

  SearchSongModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.type,
    required this.images,
    required this.explicitContent,
    required this.language,
    required this.ctr,
    required this.albumId,
    required this.albumName,
    required this.singers,
    required this.primaryArtists,
    required this.permaUrl,
  });

  factory SearchSongModel.fromMap(Map<String, dynamic> map) {
    return SearchSongModel(
      id: map['id'],
      title: map['title'],
      subtitle: map['subtitle'],
      description: map['description'],
      type: map['type'],
      images: DownloadUrl.imagesUrls(map['image']),
      explicitContent: map['explicit_content'] == '1',
      permaUrl: map['perma_url'],
      language: map['more_info']['language'],
      ctr: map['more_info']['ctr'],
      albumId: map['more_info']['album_id'],
      albumName: map['more_info']['album'],
      singers: map['more_info']['singers'],
      primaryArtists: map['more_info']['primary_artists'],
    );
  }
}
