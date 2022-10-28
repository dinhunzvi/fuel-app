import 'package:flutter/cupertino.dart';
import 'package:fuel_app/providers/auth_provider.dart';
import 'package:fuel_app/services/api.dart';

import '../models/vehicle.dart';

class VehicleProvider extends ChangeNotifier {
  List<Vehicle> vehicles = [];
  late AuthProvider authProvider;
  late ApiService apiService;

  VehicleProvider( this.authProvider) {
    apiService = ApiService( authProvider.token );

    init();
  }

  Future init() async {
    vehicles = await apiService.fetchVehicles();

    notifyListeners();

  }
}