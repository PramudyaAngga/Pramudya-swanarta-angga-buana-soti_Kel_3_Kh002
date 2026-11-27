class Admin {
  final int id;
  final String name;
  final String email;
  final String department;

  const Admin({
    required this.id,
    required this.name,
    required this.email,
    required this.department,
  });

  factory Admin.fromJson(Map<String, dynamic> json) {
    final company = json['company'];
    final department = company is Map<String, dynamic> ? company['name'] : null;
    return Admin(
      id: _toInt(json['id']),
      name: (json['name'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      department:
          (json['department'] ?? department ?? 'Administration').toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'department': department,
      };

  static int _toInt(dynamic value) =>
      value is int ? value : int.parse(value.toString());
}
