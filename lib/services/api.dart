import 'dart:convert';
import 'dart:io';
import 'package:fuel_app/models/driver.dart';
import 'package:fuel_app/models/transporter.dart';
import 'package:fuel_app/models/vehicle.dart';
import 'package:http/http.dart' as http;

class ApiService {
  late String token;

  final String baseUrl = "http://192.168.0.112:8000/api";

  ApiService(this.token);

  // get all drivers
  Future<List<Driver>> fetchDrivers() async {
    http.Response response = await http.get(
      Uri.parse(baseUrl + 'drivers'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
    );

    List drivers = jsonDecode(response.body);

    return drivers.map((driver) => Driver.fromJson(driver)).toList();
  }

  // add a new driver
  Future<Driver> addDriver(
      int transporterId, String name, String idNumber) async {
    String uri = baseUrl + 'drivers';

    http.Response response = await http.post(Uri.parse(uri),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token'
        },
        body: jsonEncode({
          'transporter_id': transporterId,
          'name': name,
          'id_number': idNumber
        }));

    if (response.statusCode != 201) {
      throw Exception('Error happened on create');
    }

    return Driver.fromJson(jsonDecode(response.body));
  }

  // update driver details
  Future<Driver> updateDriver(Driver driver) async {
    String uri = baseUrl + 'drivers/' + driver.id.toString();

    http.Response response = await http.put(
      Uri.parse(uri),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
      body: jsonEncode({
        'transporter_id': driver.transporterId,
        'name': driver.name,
        'id_number': driver.idNumber
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Error occurred on update');
    }

    return Driver.fromJson(jsonDecode(response.body));
  }

  // delete a driver
  Future<void> deleteDriver(int id) async {
    String url = baseUrl + 'drivers/' + id.toString();

    http.Response response = await http.delete(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Error deleting driver');
    }
  }

  // get all transporters
  Future<List<Transporter>> fetchTransporters() async {
    String url = baseUrl + 'transporters';
    http.Response response = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
    );

    List transporters = jsonDecode(response.body);

    return transporters
        .map((transporter) => Transporter.fromJson(transporter))
        .toList();
  }

  // add transporter
  Future<Transporter> addTransporter(String name) async {
    String uri = baseUrl + 'transporters';

    http.Response response = await http.post(Uri.parse(uri),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token'
        },
        body: jsonEncode({'name': name}));

    if (response.statusCode != 200) {
      throw Exception('Error saving transporter');
    }

    return Transporter.fromJson(jsonDecode(response.body));
  }

  // update transporter
  Future<Transporter> updateTransporter(Transporter transporter) async {
    String uri = baseUrl + 'transporters/' + transporter.id.toString();

    http.Response response = await http.put(Uri.parse(uri),
        headers: {
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token'
        },
        body: jsonEncode({'name': transporter.name}));

    if (response.statusCode != 201) {
      throw Exception('Error updating transporter');
    }

    return Transporter.fromJson(jsonDecode(response.body));
  }

  // delete transporter
  Future<void> deleteTransporter(int id) async {
    String uri = baseUrl + 'transporters/' + id.toString();

    http.Response response = await http.delete(Uri.parse(uri), headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    if (response.statusCode != 204) {
      throw Exception('Error deleting transaction');
    }
  }

  // get all vehicles
  Future<List<Vehicle>> fetchVehicles() async {
    String uri = baseUrl + 'vehicles';

    http.Response response = await http.get( Uri.parse( uri),
    headers: {
      HttpHeaders.authorizationHeader : 'Bearer $token',
      HttpHeaders.acceptHeader : 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json'
    },);

    List vehicles = jsonDecode( response.body );

    return vehicles.map((vehicle) => Vehicle.fromJson( vehicle)).toList();

  }

  // add a vehicle
  Future<Vehicle> addVehicle( int transporterId, String vehicleType,
      String regNumber) async {
    String uri = baseUrl + 'vehicles';

    http.Response response = await http.post( Uri.parse(uri),
    headers: {
      HttpHeaders.authorizationHeader : 'Bearer $token',
      HttpHeaders.acceptHeader : 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json'
    },
    body: jsonEncode({ 'transporter_id' : transporterId,
    'vehicle_type': vehicleType, 'reg_number' : regNumber }));

    if ( response.statusCode != 200 ) {
      throw Exception( 'Error saving vehicle' );
    }

    return Vehicle.fromJson( jsonDecode( response.body));
  }

  // update a vehicle
  Future<Vehicle> updateVehicle( Vehicle vehicle) async {
    String uri = baseUrl + 'vehicles/' + vehicle.id.toString();

    http.Response response = await http.put( Uri.parse(uri),
    headers: {
      HttpHeaders.authorizationHeader : 'Bearer $token',
      HttpHeaders.acceptHeader : 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json'
    },
    body: jsonEncode({}));

    if ( response.statusCode != 201 ) {
      throw Exception( 'Error updating vehicle' );
    }

    return Vehicle.fromJson( jsonDecode( response.body));

  }

  // delete a vehicle
  Future<void> deleteVehicle( int id ) async {
    String uri = baseUrl + 'vehicles/' + id.toString();

    http.Response response = await http.delete( Uri.parse( uri ),
    headers: {
      HttpHeaders.acceptHeader : 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    if ( response.statusCode != 204 ) {
      throw Exception( 'Error deleting vehicle');
    }
  }

}
