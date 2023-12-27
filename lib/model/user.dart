import '../enums/role.dart';

class User {
  int? id;
  String? name;
  String? phone;
  String? password;
  Set<Role>? roles;
  String? login;

  // Конструктор класса User
  User({
    this.id,
    this.name,
    this.phone,
    this.password,
    this.roles,
    this.login,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      password: json['password'],
      roles: json['roles'] != null
          ? Set<Role>.from(json['roles'].map((x) => Role.fromJson(x)))
          : null,
      login: json['login'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'password': password,
      'roles': List<dynamic>.from(roles!.map((x) => x.toJson())),
      'login': login,
    };
  }
}