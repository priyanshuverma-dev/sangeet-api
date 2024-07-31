// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:sangeet_api/common/constants.dart';
import 'package:sangeet_api/common/models/download_url_model.dart';
import 'package:sangeet_api/modules/album/models/album_model.dart';
import 'package:sangeet_api/modules/playlist/models/playlist_map_model.dart';
import 'package:sangeet_api/modules/song/models/song_model.dart';

class ArtistModel {
  final String id;
  final String name;
  final String subtitle;
  final List<DownloadUrl> images;
  final int followersCount;
  final String type;
  final bool isVerified;
  final String dominantLanguage;
  final String dominantType;
  final int fanCount;
  final List<SongModel> topSongs;
  final List<AlbumModel> topAlbums;
  final Color? accentColor;

  final List<PlaylistMapModel> featuredPlaylists;
  final List<PlaylistMapModel> singlesPlaylists;
  ArtistModel({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.images,
    required this.followersCount,
    required this.type,
    required this.isVerified,
    required this.dominantLanguage,
    required this.dominantType,
    this.accentColor,
    required this.fanCount,
    required this.topSongs,
    required this.topAlbums,
    required this.featuredPlaylists,
    required this.singlesPlaylists,
  });

  factory ArtistModel.fromMap(Map<String, dynamic> map) {
    return ArtistModel(
        id: map['artistId'],
        name: map['name'],
        subtitle: map['subtitle'],
        images: DownloadUrl.imagesUrls(
            map['image'] == "" ? Constants.artistDefaultImage : map['image']),
        followersCount: int.parse('0${map['follower_count']}'),
        type: map['type'],
        isVerified: map['isVerified'],
        dominantLanguage: map['dominantLanguage'],
        dominantType: map['dominantType'],
        fanCount: int.parse(map['fan_count'] as String),
        topSongs: List<SongModel>.from(
          (map['topSongs']).map(
            (e) => SongModel.fromMap(e),
          ),
        ),
        topAlbums: List<AlbumModel>.from(
          (map['topAlbums']).map(
            (e) => AlbumModel.fromMap(e),
          ),
        ),
        featuredPlaylists: List<PlaylistMapModel>.from(
          (map['featured_artist_playlist']).map(
            (e) => PlaylistMapModel.fromMap(e),
          ),
        ),
        singlesPlaylists: List<PlaylistMapModel>.from(
          (map['singles']).map(
            (e) => PlaylistMapModel.fromMap(e),
          ),
        ));
  }

  @override
  String toString() {
    return 'ArtistModel(id: $id, name: $name, subtitle: $subtitle, images: $images, followersCount: $followersCount, type: $type, isVerified: $isVerified, dominantLanguage: $dominantLanguage, dominantType: $dominantType, fanCount: $fanCount, topSongs: $topSongs)';
  }

  ArtistModel copyWith({
    String? id,
    String? name,
    String? subtitle,
    List<DownloadUrl>? images,
    int? followersCount,
    String? type,
    bool? isVerified,
    String? dominantLanguage,
    String? dominantType,
    List<String>? availableLanguages,
    int? fanCount,
    List<SongModel>? topSongs,
    List<AlbumModel>? topAlbums,
    List<PlaylistMapModel>? featuredPlaylists,
    List<PlaylistMapModel>? singlesPlaylists,
    Color? accentColor,
  }) {
    return ArtistModel(
      id: id ?? this.id,
      name: name ?? this.name,
      subtitle: subtitle ?? this.subtitle,
      images: images ?? this.images,
      followersCount: followersCount ?? this.followersCount,
      type: type ?? this.type,
      isVerified: isVerified ?? this.isVerified,
      dominantLanguage: dominantLanguage ?? this.dominantLanguage,
      dominantType: dominantType ?? this.dominantType,
      accentColor: accentColor ?? this.accentColor,
      fanCount: fanCount ?? this.fanCount,
      topSongs: topSongs ?? this.topSongs,
      topAlbums: topAlbums ?? this.topAlbums,
      featuredPlaylists: featuredPlaylists ?? this.featuredPlaylists,
      singlesPlaylists: singlesPlaylists ?? this.singlesPlaylists,
    );
  }
}
