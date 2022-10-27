class User {
  int id;
  String name;
  String email;
  String dateCreated;
  String dateUpdated;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.dateCreated,
      required this.dateUpdated});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        dateCreated: json['date_created'],
        dateUpdated: json['date_updated']);
  }
}
