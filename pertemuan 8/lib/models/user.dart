class User {
  final int id;
  final String name;
  final String email;
  final String city;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.city,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final address = json['address'];
    final city = address is Map<String, dynamic> ? address['city'] : null;
    return User(
      id: _toInt(json['id']),
      name: (json['name'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      city: (city ?? json['city'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'address': {'city': city},
      };

  User copyWith({String? name, String? email, String? city}) => User(
        id: id,
        name: name ?? this.name,
        email: email ?? this.email,
        city: city ?? this.city,
      );

  static int _toInt(dynamic value) =>
      value is int ? value : int.parse(value.toString());
}
