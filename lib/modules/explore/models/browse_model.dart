import 'package:sangeet_api/modules/album/models/album_model.dart';
import 'package:sangeet_api/modules/explore/models/trend_model.dart';
import 'package:sangeet_api/modules/playlist/models/playlist_map_model.dart';

import 'browse_chart_model.dart';
import 'browse_radio_model.dart';

class BrowseModel {
  final List<BrowseChartModel> charts;
  final List<AlbumModel> albums;
  final List<PlaylistMapModel> topPlaylists;
  final List<BrowseRadioModel> radios;
  final List<TrendModel> trending;

  BrowseModel({
    required this.charts,
    required this.albums,
    required this.topPlaylists,
    required this.radios,
    required this.trending,
  });

  factory BrowseModel.fromMap(Map<String, dynamic> map) {
    return BrowseModel(
      charts: List<BrowseChartModel>.from(map['charts'].map<BrowseChartModel>(
        (e) => BrowseChartModel.fromMap(e),
      )),
      albums: List<AlbumModel>.from(map['new_albums'].map<AlbumModel>(
        (e) => AlbumModel.fromMap(e),
      )),
      topPlaylists: List<PlaylistMapModel>.from(
          map['top_playlists'].map<PlaylistMapModel>(
        (e) => PlaylistMapModel.fromMap(e),
      )),
      radios: List<BrowseRadioModel>.from(
          map['radio']['featured_stations'].map<BrowseRadioModel>(
        (e) => BrowseRadioModel.fromMap(e),
      )),
      trending: List<TrendModel>.from(map['new_trending'].map<TrendModel>(
        (e) => TrendModel(
          id: e['id'],
          title: e['title'],
          subtitle: e['subtitle'] != "" ? e['subtitle'] : e["language"],
          type: e['type'],
          image: e['image'],
          url: e['perma_url'],
          explicitContent: e["explicit_content"] == "1",
        ),
      )),
    );
  }
}
