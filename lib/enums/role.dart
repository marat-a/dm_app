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
      name: _convertStringToERole(json['name'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': _convertERoleToString(name),
    };
  }

  static ERole _convertStringToERole(String value) {
    switch (value) {
      case 'ADMIN':
        return ERole.ADMIN;
      case 'MANAGER':
        return ERole.MANAGER;
      case 'COURIER':
        return ERole.COURIER;
      case 'CUSTOMER':
        return ERole.CUSTOMER;
      default:
        throw Exception('Invalid ERole: $value');
    }
  }

  static String _convertERoleToString(ERole eRole) {
    return eRole.toString().split('.').last;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Role &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name.name == other.name.name&&
  name.index == other.name.index;
}
