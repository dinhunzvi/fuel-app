import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;


class ApiService {
  late String token;

  final String baseUrl = "http://192.168.0.112:8000/api";

  ApiService( this.token );


}