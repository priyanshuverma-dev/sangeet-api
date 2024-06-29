class BrowseChartModel {
  final String id;
  final String title;
  final String subtitle;
  final String image;
  final bool explicitContent;
  final String language;
  final String permaUrl;
  final String token;

  BrowseChartModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.explicitContent,
    required this.language,
    required this.permaUrl,
    required this.token,
  });

  factory BrowseChartModel.fromMap(Map<String, dynamic> map) {
    String urlString = map['perma_url'];
    // Parse the URL
    Uri url = Uri.parse(urlString);
    // Extract the path segments
    List<String> pathSegments = url.pathSegments;
    // Get the desired segment (last segment)
    String desiredSegment = pathSegments.last;

    return BrowseChartModel(
      id: map['id'],
      permaUrl: map['perma_url'],
      token: desiredSegment,
      title: map['title'],
      subtitle: map['subtitle'],
      image: map['image'],
      explicitContent: map['explicit_content'] == "1",
      language: map['language'],
    );
  }
}
