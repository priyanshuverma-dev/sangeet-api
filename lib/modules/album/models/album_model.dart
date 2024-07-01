// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sangeet_api/common/models/download_url_model.dart';
import 'package:sangeet_api/modules/artists/models/artist_map_model.dart';
import 'package:sangeet_api/modules/song/models/song_model.dart';

class AlbumModel {
  final String id;
  final String title;
  final String subtitle;
  final String type;
  final List<DownloadUrl> images;
  final String language;
  final String year;
  final int playCount;
  final bool explicitContent;
  final int listCount;
  final String listType;
  final String? copyright;
  final List<ArtistMapModel> artists;
  final List<SongModel> songs;

  AlbumModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.images,
    required this.language,
    required this.year,
    required this.playCount,
    required this.explicitContent,
    required this.listCount,
    required this.listType,
    this.copyright,
    required this.artists,
    required this.songs,
  });

  factory AlbumModel.fromMap(Map<String, dynamic> map) {
    return AlbumModel(
      id: map['id'],
      title: map['title'],
      subtitle: map['subtitle'],
      type: map['type'],
      images: DownloadUrl.imagesUrls(map['image']),
      language: map['language'],
      year: map['year'],
      playCount: int.parse("0${map['play_count']}"),
      explicitContent: map['explicit_content'] == "1",
      listCount: int.parse(map['list_count']),
      listType: map['list_type'],
      copyright: map['more_info']['copyright_text'],
      artists: List<ArtistMapModel>.from(
        (map['more_info']['artistMap']['artists']).map(
          (e) => ArtistMapModel.fromMap(e),
        ),
      ),
      songs: map['list'] == ""
          ? []
          : List<SongModel>.from(
              (map['list']).map(
                (e) => SongModel.fromMap(e),
              ),
            ),
    );
  }

  @override
  String toString() {
    return 'AlbumModel(id: $id, title: $title, subtitle: $subtitle, type: $type, images: $images, language: $language, year: $year, playCount: $playCount, explicitContent: $explicitContent, listCount: $listCount, listType: $listType, copyright: $copyright, artists: $artists, songs: $songs)';
  }

  AlbumModel copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? type,
    List<DownloadUrl>? images,
    String? language,
    String? year,
    int? playCount,
    bool? explicitContent,
    int? listCount,
    String? listType,
    String? copyright,
    List<ArtistMapModel>? artists,
    List<SongModel>? songs,
  }) {
    return AlbumModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      type: type ?? this.type,
      images: images ?? this.images,
      language: language ?? this.language,
      year: year ?? this.year,
      playCount: playCount ?? this.playCount,
      explicitContent: explicitContent ?? this.explicitContent,
      listCount: listCount ?? this.listCount,
      listType: listType ?? this.listType,
      copyright: copyright ?? this.copyright,
      artists: artists ?? this.artists,
      songs: songs ?? this.songs,
    );
  }
}
