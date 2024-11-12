// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:sangeet_api/common/models/download_url_model.dart';
import 'package:sangeet_api/modules/artists/models/artist_map_model.dart';

class SongModel {
  final String id;
  final String title;
  final String subtitle;
  final String label;
  final String type;
  final List<DownloadUrl> images;
  final String language;
  final String year;
  final int playCount;
  final bool explicitContent;
  final String? lyricsId;
  final String? releaseDate;
  final int duration;
  final String copyright;
  final String? albumId;
  final String albumName;
  final List<ArtistMapModel> artists;
  final List<DownloadUrl> urls;
  final String permaUrl;
  final Color? accentColor;

  SongModel({
    required this.id,
    required this.title,
    this.accentColor,
    required this.subtitle,
    required this.label,
    required this.type,
    required this.images,
    required this.language,
    required this.year,
    required this.playCount,
    required this.explicitContent,
    required this.lyricsId,
    this.releaseDate,
    required this.duration,
    required this.copyright,
    required this.albumId,
    required this.albumName,
    required this.artists,
    required this.urls,
    required this.permaUrl,
  });

  factory SongModel.fromMap(Map<String, dynamic> map) {
    return SongModel(
      id: map["id"] as String,
      title: decodeHtmlEntities(map["title"] as String),
      subtitle: decodeHtmlEntities(map["subtitle"] as String),
      type: map["type"] as String,
      permaUrl: map["perma_url"] as String,
      language: map["language"] as String,
      year: map["year"] as String,
      playCount: int.parse("0${map["play_count"]}"),
      explicitContent: map["explicit_content"] == "1",
      images: DownloadUrl.imagesUrls(map['image']), // !TODO!
      label: map["more_info"]['label'] as String,
      lyricsId: map["id"],
      releaseDate: map["more_info"]['release_date'],
      duration: int.parse(map["more_info"]['duration']),
      copyright: map["more_info"]['copyright_text'],
      albumId: map["more_info"]['album_id'],
      albumName: map["more_info"]['album'],
      artists: List<ArtistMapModel>.from(
        (map["more_info"]['artistMap']['artists'])
            .map((e) => ArtistMapModel.fromMap(e)),
      ),
      urls: DownloadUrl.songUrls(map['more_info']['encrypted_media_url']),
    );
  }

  @override
  String toString() {
    return """
      id: $id \n
      title: $title \n
      subtitle: $subtitle \n
      label: $label \n
      type: $type \n
      images: $images \n
      language: $language \n
      year: $year \n
      playCount: $playCount \n
      explicitContent: $explicitContent \n
      lyricsId: $lyricsId \n
      releaseDate: $releaseDate \n
      duration: $duration \n
      copyright: $copyright \n
      albumId: $albumId \n
      albumName: $albumName \n
      artists: $artists \n
      urls: $urls \n
      permaUrl: $permaUrl \n

""";
  }

  SongModel copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? label,
    String? type,
    List<DownloadUrl>? images,
    String? language,
    String? year,
    int? playCount,
    bool? explicitContent,
    String? lyricsId,
    String? releaseDate,
    int? duration,
    String? copyright,
    String? albumId,
    String? albumName,
    List<ArtistMapModel>? artists,
    List<DownloadUrl>? urls,
    String? permaUrl,
    Color? accentColor,
  }) {
    return SongModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      label: label ?? this.label,
      type: type ?? this.type,
      accentColor: accentColor ?? this.accentColor,
      images: images ?? this.images,
      language: language ?? this.language,
      year: year ?? this.year,
      playCount: playCount ?? this.playCount,
      explicitContent: explicitContent ?? this.explicitContent,
      lyricsId: lyricsId ?? this.lyricsId,
      releaseDate: releaseDate ?? this.releaseDate,
      duration: duration ?? this.duration,
      copyright: copyright ?? this.copyright,
      albumId: albumId ?? this.albumId,
      albumName: albumName ?? this.albumName,
      artists: artists ?? this.artists,
      urls: urls ?? this.urls,
      permaUrl: permaUrl ?? this.permaUrl,
    );
  }
}

String decodeHtmlEntities(String input) {
  final entities = {
    '&quot;': '"',
    '&apos;': "'",
    '&amp;': '&',
    '&lt;': '<',
    '&gt;': '>',
    '&nbsp;': ' ',
    '&copy;': '©',
    '&reg;': '®',
    '&euro;': '€',
    '&pound;': '£',
    '&yen;': '¥',
    // Add more entities as needed
  };

  entities.forEach((entity, character) {
    input = input.replaceAll(entity, character);
  });

  return input;
}
