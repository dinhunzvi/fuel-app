import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api.dart';

class AuthProvider extends ChangeNotifier {

  late String token;

  bool isAuthenticated = false;

  late ApiService apiService;

  AuthProvider() {
    init();
  }

  Future<void> init() async {
    token = await getToken();

    if ( token.isNotEmpty) {
      isAuthenticated = true;
    }

    apiService = ApiService( token );

    notifyListeners();

  }

  Future<void> logout() async {
    token = '';
    isAuthenticated = false;

    setToken(token);

    notifyListeners();

  }

  Future<void> login( String email, String password, String deviceName ) async {

  }

  Future<void> setToken( String token ) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString( 'token', token );

  }

  Future<String> getToken() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    return sharedPreferences.getString( 'token' ) ?? '';

  }

}