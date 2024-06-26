class ArtistMapModel {
  final String id;
  final String name;
  final String role;
  final String type;
  final String image;
  final String url;

  ArtistMapModel({
    required this.id,
    required this.name,
    required this.role,
    required this.type,
    required this.image,
    required this.url,
  });

  factory ArtistMapModel.fromMap(Map<String, dynamic> map) {
    return ArtistMapModel(
      id: map['id'] as String,
      name: map['name'] as String,
      role: map['role'] as String,
      type: map['type'] as String,
      image: map['image'] as String,
      url: map['perma_url'] as String,
    );
  }
  @override
  String toString() {
    return 'ArtistMapModel{id: $id, name: $name, role: $role, type: $type, image: $image, url: $url}';
  }
}
