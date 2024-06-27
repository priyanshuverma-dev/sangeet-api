import 'package:sangeet_api/common/utils.dart';

class DownloadUrl {
  final String quality;
  final String url;

  DownloadUrl({
    required this.quality,
    required this.url,
  });

  static List<DownloadUrl> imagesUrls(String encryptedUrl) {
    final list = Utils.createImageUrls(encryptedUrl);
    return list;
  }

  static List<DownloadUrl> songUrls(String encryptedUrl) {
    final list = Utils.createDownloadUrls(encryptedUrl);
    return list;
  }

  @override
  String toString() {
    return "QUALITY: $quality URL: $url";
  }
}
