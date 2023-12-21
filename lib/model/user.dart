import '../enums/role.dart';

class User {
  int? id;
  String? name;
  String? phone;
  String? password;
  Set<Role>? roles;
  String? login;



  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      password: json['password'],
      roles: Set<Role>.from(json['roles'].map((x) => Role.fromJson(x))),
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

  User(
      this.id, this.name, this.phone, this.password, this.roles, this.login, {required id});
}