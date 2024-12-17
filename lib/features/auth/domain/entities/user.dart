class User {
  final String id;
  final String name;
  final String email;
  final String accessToken;
  final String refreshToken;
  final String? nickname;
  final String? profileImageUrl;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.accessToken,
    required this.refreshToken,
    this.nickname,
    this.profileImageUrl,
  });
}
