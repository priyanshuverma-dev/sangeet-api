import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sangeet_api/common/endpoints.dart';
import 'package:sangeet_api/modules/artists/models/artist_map_model.dart';

class SongController {
  final Dio _client;

  SongController({
    required Dio client,
  }) : _client = client;

  Future<dynamic> getById({required String songId}) async {
    try {
      final res = await _client.get("/", queryParameters: {
        "ctx": "web6dot0",
        "__call": Endpoints.songs.id,
        "pids": songId,
      });

      final resp = jsonDecode(res.data);
      if (res.statusCode != 200 || resp["status"] == "failure") {
        throw Error.throwWithStackTrace(resp["msg"], StackTrace.current);
      }

      final f = File('E:/code/apps/sangeet_api/data.json');
      f.createSync();
      f.writeAsStringSync(jsonEncode(resp));

      final artists = resp['songs'][0]['more_info']['artistMap']
              ['primary_artists']
          .map((e) => ArtistMapModel.fromMap(e));

      return artists;
    } catch (e) {
      if (kDebugMode) {
        print("ERROR: $e");
      }
      return null;
    }
  }
}
