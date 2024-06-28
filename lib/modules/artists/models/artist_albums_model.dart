import 'package:sangeet_api/modules/album/models/album_model.dart';

class ArtistAlbumsModel {
  final int total;
  final List<AlbumModel> albums;

  ArtistAlbumsModel({
    required this.total,
    required this.albums,
  });
}
