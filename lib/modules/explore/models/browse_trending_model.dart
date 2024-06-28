import 'package:sangeet_api/modules/album/models/album_model.dart';
import 'package:sangeet_api/modules/playlist/models/playlist_map_model.dart';
import 'package:sangeet_api/modules/song/models/song_model.dart';

class BrowseTrendingModel {
  final List<SongModel> songs;
  final List<AlbumModel> albums;
  final List<PlaylistMapModel> playlists;
  final int total;

  BrowseTrendingModel({
    required this.albums,
    required this.songs,
    required this.playlists,
    required this.total,
  });

  factory BrowseTrendingModel.fromMap(List<dynamic> map) {
    List<SongModel> songsList = [];
    List<AlbumModel> albumsList = [];
    List<PlaylistMapModel> playlistsList = [];

    for (var item in map) {
      switch (item['type']) {
        case 'song':
          songsList.add(SongModel.fromMap(item));
          break;
        case 'album':
          albumsList.add(AlbumModel.fromMap(item));
          break;
        case 'playlist':
          playlistsList.add(PlaylistMapModel.fromMap(item));
          break;
        default:
          throw Exception('Unknown type: ${item['type']}');
      }
    }

    return BrowseTrendingModel(
      albums: albumsList,
      songs: songsList,
      playlists: playlistsList,
      total: albumsList.length + playlistsList.length + songsList.length,
    );
  }
}
