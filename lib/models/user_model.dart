class User {
  final String id;
  final String name;
  final String email;
  final String? profileImageUrl;
  final String? preferences;

  User(
      {required this.id,
      required this.name,
      required this.email,
      this.profileImageUrl,
      this.preferences});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      profileImageUrl: json['profileImageUrl'],
      preferences: json['preferences'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profileImageUrl': profileImageUrl,
      'preferences':preferences
    };
  }
}
