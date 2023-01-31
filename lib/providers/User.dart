class User {
  String id;
  String name;
  String? imageUrl;

  User({
    required this.id,
    required this.name,
    this.imageUrl,
  });
}
