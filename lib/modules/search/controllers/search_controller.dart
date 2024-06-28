import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sangeet_api/common/endpoints.dart';

class SearchController {
  final Dio _client;

  SearchController({
    required Dio client,
  }) : _client = client;

  Future<dynamic> global({required String query}) async {
    try {
      final res = await _client.get("/", queryParameters: {
        "ctx": "web6dot0",
        "__call": Endpoints.search.all,
        "query": query.replaceAll(' ', '+'),
      });

      final resp = jsonDecode(res.data);

      // final f = File('./search-all.json');
      // f.createSync();
      // f.writeAsStringSync(res.data);

      if (resp == []) {
        throw Error.throwWithStackTrace(
            "No results found for $query", StackTrace.current);
      }
    } catch (e) {
      if (kDebugMode) {
        print("GLOBAL SEARCH ERROR: $e");
      }
      return null;
    }
  }
}
