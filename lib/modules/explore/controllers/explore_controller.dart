import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sangeet_api/common/endpoints.dart';
import 'package:sangeet_api/modules/explore/models/browse_model.dart';
import 'package:sangeet_api/modules/explore/models/browse_trending_model.dart';
import 'package:sangeet_api/modules/playlist/models/playlist_model.dart';

class ExploreController {
  final Dio _client;
  ExploreController({
    required Dio client,
  }) : _client = client;

  Future<BrowseModel?> browse() async {
    try {
      final res = await _client.get("/", queryParameters: {
        "ctx": "web6dot0",
        "__call": Endpoints.modules,
      });

      final resp = jsonDecode(res.data);

      if (resp["error"] != null) {
        throw Error.throwWithStackTrace("Can't fetch data", StackTrace.current);
      }

      final results = BrowseModel.fromMap(resp);

      return results;
    } catch (e, st) {
      if (kDebugMode) {
        print("ERROR: $e \n $st");
      }
      return null;
    }
  }

  Future<BrowseTrendingModel?> trending({int limit = 10}) async {
    try {
      assert(limit >= 10, "Limit should be greater or equal to 10");

      final res = await _client.get("/", queryParameters: {
        "ctx": "web6dot0",
        "__call": Endpoints.trending,
        'n': limit,
      });

      final resp = jsonDecode(res.data);
      if (resp == []) {
        throw Error.throwWithStackTrace("Can't fetch data", StackTrace.current);
      }

      final results = BrowseTrendingModel.fromMap(resp);

      return results;
    } catch (e, st) {
      if (kDebugMode) {
        print("ERROR: $e \n $st");
      }
      return null;
    }
  }

  Future<PlaylistModel?> chart({
    required String token,
    int page = 1,
    int limit = 25,
  }) async {
    try {
      assert(limit >= 10, "Limit should be greater or equal to 10");
      assert(page >= 1, "Page should be greater or equal to 1");

      final res = await _client.get("/", queryParameters: {
        "ctx": "web6dot0",
        "__call": Endpoints.get,
        'n': limit,
        "token": token,
        "type": 'playlist',
      });

      final resp = jsonDecode(res.data);
      if (resp == []) {
        throw Error.throwWithStackTrace("Can't fetch data", StackTrace.current);
      }

      final results = PlaylistModel.fromMap(resp);
      return results;
    } catch (e, st) {
      if (kDebugMode) {
        print("ERROR: $e \n $st");
      }
      return null;
    }
  }

  //
}
