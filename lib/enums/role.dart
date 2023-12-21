import '../model/erole.dart';

class Role {
  int id;
  ERole name;

  Role({
    required this.id,
    required this.name,
  });


  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      name: ERole.fromJson(json['name']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name.toJson(),
    };
  }
}
