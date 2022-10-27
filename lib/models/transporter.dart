class Transporter {
  int id;
  String name;
  String dateCreated;
  String dateUpdated;

  Transporter(
      {required this.id,
      required this.name,
      required this.dateCreated,
      required this.dateUpdated});

  factory Transporter.fromJson(Map<String, dynamic> json) {
    return Transporter(
        id: json['id'],
        name: json['name'],
        dateCreated: json['dateCreated'],
        dateUpdated: json['dateUpdated']);
  }
}
