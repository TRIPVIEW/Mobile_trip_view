class User {
  final String id;
  final String name;
  final String email;
  final String? nickname;
  final String? profileImageUrl;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.nickname,
    this.profileImageUrl,
  });
}
