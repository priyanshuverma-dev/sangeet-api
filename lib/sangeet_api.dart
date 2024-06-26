library sangeet_api;

import 'package:dio/dio.dart';
import 'package:sangeet_api/common/constants.dart';
import 'package:sangeet_api/modules/song/controllers/song_controller.dart';

class SangeetAPI {
  final Dio client = Dio(
    BaseOptions(
      baseUrl: Constants.serverUrl,
      queryParameters: Constants.defaultQueries,
    ),
  );

  SongController get song => SongController(client: client);
}
