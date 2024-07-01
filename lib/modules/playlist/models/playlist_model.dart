// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sangeet_api/common/models/download_url_model.dart';
import 'package:sangeet_api/modules/artists/models/artist_map_model.dart';
import 'package:sangeet_api/modules/song/models/song_model.dart';

class PlaylistModel {
  final String id;
  final String title;
  final String subtitle;
  final String type;
  final List<DownloadUrl> images;
  final String? language;
  final String? year;
  final int playCount;
  final bool explicitContent;
  final int fanCount;
  final int followerCount;
  final List<ArtistMapModel> artists;
  final List<SongModel> songs;
  PlaylistModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.images,
    this.language,
    this.year,
    required this.playCount,
    required this.explicitContent,
    required this.fanCount,
    required this.followerCount,
    required this.artists,
    required this.songs,
  });

  factory PlaylistModel.fromMap(Map<String, dynamic> map) {
    return PlaylistModel(
      id: map['id'],
      title: map['title'],
      subtitle: map['subtitle'],
      type: map['type'],
      images: DownloadUrl.imagesUrls(map['image']),
      playCount: int.parse("0${map['play_count'] ?? ""}"),
      explicitContent: map['explicit_content'] == '1',
      fanCount:
          int.parse('0${map['more_info']['fan_count'].replaceAll(',', '')}'),
      followerCount: int.parse('0${map['more_info']['follower_count']}'),
      artists: List<ArtistMapModel>.from(
        (map['more_info']['artists']).map(
          (e) => ArtistMapModel.fromMap(e),
        ),
      ),
      songs: List<SongModel>.from(
        (map['list']).map(
          (e) => SongModel.fromMap(e),
        ),
      ),
    );
  }

  PlaylistModel copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? type,
    List<DownloadUrl>? images,
    String? language,
    String? year,
    int? playCount,
    bool? explicitContent,
    int? fanCount,
    int? followerCount,
    List<ArtistMapModel>? artists,
    List<SongModel>? songs,
  }) {
    return PlaylistModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      type: type ?? this.type,
      images: images ?? this.images,
      language: language ?? this.language,
      year: year ?? this.year,
      playCount: playCount ?? this.playCount,
      explicitContent: explicitContent ?? this.explicitContent,
      fanCount: fanCount ?? this.fanCount,
      followerCount: followerCount ?? this.followerCount,
      artists: artists ?? this.artists,
      songs: songs ?? this.songs,
    );
  }
}
