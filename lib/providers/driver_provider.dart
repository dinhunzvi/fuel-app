import 'package:flutter/cupertino.dart';
import 'package:fuel_app/providers/auth_provider.dart';
import 'package:fuel_app/services/api.dart';

import '../models/driver.dart';

class DriverProvider extends ChangeNotifier {
  List<Driver> drivers = [];
  late ApiService apiService;
  late AuthProvider authProvider;

  DriverProvider(this.authProvider) {
    apiService = ApiService(authProvider.token);

    init();
  }

  Future init() async {
    drivers = await apiService.fetchDrivers();

    notifyListeners();
  }

  // add driver
  Future addDriver(int transporterId, String name, String idNumber) async {
    try {
      Driver addedDriver =
          await apiService.addDriver(transporterId, name, idNumber);

      drivers.add(addedDriver);

      notifyListeners();
    } on Exception {
      await authProvider.logout();
    }
  }

  // update a driver
  Future updateDriver(Driver driver) async {
    try {
      Driver updatedDriver = await apiService.updateDriver(driver);

      int index = drivers.indexOf(updatedDriver);
      drivers[index] = updatedDriver;

      notifyListeners();
    } on Exception {
      await authProvider.logout();
    }
  }

  // delete a driver
  Future<void> deleteDriver( Driver driver ) async {
    try {
      await apiService.deleteDriver( driver.id );

      drivers.remove( driver );

      notifyListeners();

    } on Exception {
      await authProvider.logout();
    }
  }
}
