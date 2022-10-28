import 'package:flutter/cupertino.dart';
import 'package:fuel_app/providers/auth_provider.dart';
import 'package:fuel_app/services/api.dart';

import '../models/transporter.dart';

class TransporterProvider extends ChangeNotifier {
  List<Transporter> transporters = [];
  late ApiService apiService;
  late AuthProvider authProvider;

  TransporterProvider(this.authProvider) {
    apiService = ApiService(authProvider.token);

    init();
  }

  Future init() async {
    transporters = await apiService.fetchTransporters();

    notifyListeners();
  }

  // add transaction
  Future addTransaction(String name) async {
    try {
      Transporter addedTransporter = await apiService.addTransporter(name);

      transporters.add(addedTransporter);

      notifyListeners();
    } on Exception {
      await authProvider.logout();
    }
  }

  // update transporter
  Future updateTransporter(Transporter transporter) async {
    try {
      Transporter updatedTransporter =
          await apiService.updateTransporter(transporter);

      int index = transporters.indexOf(transporter);

      transporters[index] = updatedTransporter;

      notifyListeners();
    } on Exception {
      await authProvider.logout();
    }
  }

  // delete transporter
  Future<void> deleteTransporter(Transporter transporter) async {
    try {
      await apiService.deleteTransporter(transporter.id);

      transporters.remove(transporter);

      notifyListeners();
    } on Exception {
      await authProvider.logout();
    }
  }
}
