class User {
  const User({required this.id, required this.username});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      username: json['username'] as String,
    );
  }

  final String id;
  final String username;

  String toJson() {
    return '{"id": "$id", "username": "$username"}';
  }
}
