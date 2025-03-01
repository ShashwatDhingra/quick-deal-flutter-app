class User {
  final String id;
  final String email;
  final String name;
  final String role;

  User({
    required this.id,
    required this.email,
    required this.name,
    this.role = 'employee',
  });

  // Convert a JSON object to a User instance
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      role: json['role'] ?? 'employee',
    );
  }

  // Convert a User instance to a JSON object
  Map<String, dynamic> toJson() {
    return {'email': email, 'name': name, 'role': role, 'id': id};
  }

  // CopyWith method to update only specific fields
  User copyWith({String? email, String? name, String? role}) {
    return User(
      id: id,
      email: email ?? this.email,
      name: name ?? this.name,
      role: role ?? this.role,
    );
  }
}
