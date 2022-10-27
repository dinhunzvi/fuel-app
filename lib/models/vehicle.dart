class Vehicle {
  int id;
  int transporterId;
  String transporter;
  String vehicleType;
  String registrationNumber;
  String dateCreated;
  String dateUpdated;

  Vehicle(
      {required this.id,
      required this.transporterId,
      required this.transporter,
      required this.vehicleType,
      required this.registrationNumber,
      required this.dateCreated,
      required this.dateUpdated});

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
        id: json['id'],
        transporterId: json['transporter_id'],
        transporter: json['transporter'],
        vehicleType: json['vehicle_type'],
        registrationNumber: json['reg_number'],
        dateCreated: json['date_created'],
        dateUpdated: json['date_updated']);
  }
}
