// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

class TrendModel {
  final String id;
  final String title;
  final String subtitle;
  final String image;
  final String url;
  final Color? accentColor;
  final bool explicitContent;

  TrendModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
    this.accentColor,
    required this.url,
    required this.explicitContent,
  });

  TrendModel copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? image,
    String? url,
    Color? accentColor,
    bool? explicitContent,
  }) {
    return TrendModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      image: image ?? this.image,
      url: url ?? this.url,
      accentColor: accentColor ?? this.accentColor,
      explicitContent: explicitContent ?? this.explicitContent,
    );
  }
}
