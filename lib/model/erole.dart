class ERole {
  String value;

  ERole(this.value);

  factory ERole.fromJson(String value) {
    return ERole(value);
  }

  String toJson() {
    return value;
  }
}