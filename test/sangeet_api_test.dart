import 'package:flutter_test/flutter_test.dart';
import 'package:sangeet_api/modules/artists/models/artist_map_model.dart';

import 'package:sangeet_api/sangeet_api.dart';

void main() {
  final api = SangeetAPI();

  test("Song by ID", () async {
    final res = await api.song.getById(songId: "3IoDK8qI");
    print("RES: $res");
    expect(res, res);
  });
}
