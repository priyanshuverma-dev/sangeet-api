import 'dart:io';

import 'package:sangeet_api/common/models/download_url_model.dart';
import 'package:tripledes_nullsafety/tripledes_nullsafety.dart';

enum ImageQuality {
  low('50x50'),
  medium("150x150"),
  high('500x500');

  final String quality;
  const ImageQuality(this.quality);
}

enum SongQuality {
  v12kbps('_12'),
  v48kbps('_48'),
  v96kbps('_96'),
  v160kbps('_160'),
  v320kbps('_320');

  final String quality;
  const SongQuality(this.quality);
}

class Utils {
  static List<DownloadUrl> createImageUrls(String link) {
    const qualities = ImageQuality.values;
    final RegExp qualityRegex = RegExp(r'150x150|50x50');
    final RegExp protocolRegex = RegExp(r'^http://');

    return qualities.map((imgQ) {
      return DownloadUrl(
        quality: imgQ.quality,
        url: link
            .replaceAll(qualityRegex, imgQ.quality)
            .replaceAll(protocolRegex, 'https://'),
      );
    }).toList();
  }

  static List<DownloadUrl> createDownloadUrls(String encryptedMediaUrl) {
    const qualities = SongQuality.values;

    const String key = '38346591';
    var blockCipher = BlockCipher(DESEngine(), key);
    var decryptedLink = blockCipher.decodeB64(encryptedMediaUrl);

    return qualities.map((e) {
      final url = decryptedLink.replaceAll('_96', e.quality);
      return DownloadUrl(
        quality: e.name,
        url: url,
      );
    }).toList();
  }

  static String defaultDownloadPath() {
    final currentPath = Directory.current.path;
    return "$currentPath/downloads";
  }
}
