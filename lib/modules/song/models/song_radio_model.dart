import 'package:sangeet_api/modules/song/models/song_model.dart';

class SongRadioModel {
  final int total;
  final String? stationId;
  final List<SongModel> songs;

  SongRadioModel({
    required this.total,
    required this.stationId,
    required this.songs,
  });
}
