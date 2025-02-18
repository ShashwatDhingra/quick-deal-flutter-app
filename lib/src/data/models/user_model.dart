class User {
  final String email;
  final String name;
  final String role;

  User({
    required this.email,
    required this.name,
    this.role = 'employee',
  });

  // Convert a JSON object to a User instance
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      name: json['name'],
      role: json['role'] ?? 'employee',
    );
  }

  // Convert a User instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'role': role,
    };
  }

  // CopyWith method to update only specific fields
  User copyWith({String? email, String? name, String? role}) {
    return User(
      email: email ?? this.email,
      name: name ?? this.name,
      role: role ?? this.role,
    );
  }
}
