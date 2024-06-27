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
  final String? bio;
  final String? dob;
  final String? fb;
  final String? twitter;
  final String? wiki;
  final List<String> availableLanguages;
  final int fanCount;
  final List<SongModel> topSongs;
  final List<AlbumModel> topAlbums;
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
    this.bio,
    this.dob,
    this.fb,
    this.twitter,
    this.wiki,
    required this.availableLanguages,
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
        images: DownloadUrl.imagesUrls(map['image']),
        followersCount: int.parse(map['follower_count']),
        type: map['type'],
        isVerified: map['isVerified'],
        dominantLanguage: map['dominantLanguage'],
        dominantType: map['dominantType'],
        availableLanguages:
            List<String>.from(map['availableLanguages'].map((e) => e)),
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
    return 'ArtistModel(id: $id, name: $name, subtitle: $subtitle, images: $images, followersCount: $followersCount, type: $type, isVerified: $isVerified, dominantLanguage: $dominantLanguage, dominantType: $dominantType, bio: $bio, dob: $dob, fb: $fb, twitter: $twitter, wiki: $wiki, availableLanguages: $availableLanguages, fanCount: $fanCount, topSongs: $topSongs)';
  }
}
