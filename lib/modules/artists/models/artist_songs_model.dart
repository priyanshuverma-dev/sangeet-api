import 'package:sangeet_api/modules/song/models/song_model.dart';

class ArtistSongsModel {
  final int total;
  final List<SongModel> songs;

  ArtistSongsModel({
    required this.total,
    required this.songs,
  });
}
