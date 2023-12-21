import 'erole.dart';

class Role {
  int id;
  ERole name;

  Role({
    required this.id,
    required this.name,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'] as int,
      name: ERole.values.firstWhere((role) => role.toString() == 'ERole.${json['name']}'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name.toString().split('.').last,
    };
  }
}
