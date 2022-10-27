class Driver {
  int id;
  int transporterId;
  String transporter;
  String name;
  String idNumber;
  String dateCreated;
  String dateUpdated;

  Driver(
      {required this.id,
      required this.transporterId,
      required this.transporter,
      required this.name,
      required this.idNumber,
      required this.dateCreated,
      required this.dateUpdated});

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
        id: json['id'],
        transporterId: json['transported_id'],
        transporter: json['transporter'],
        name: json['name'],
        idNumber: json['id_number'],
        dateCreated: json['date_created'],
        dateUpdated: json['date_updated']);
  }
}
