import 'dart:io';

class Environment {

  static String apiUrl    = Platform.isAndroid  ? 'http://127.0.0.1:3000/api' : 'http://localhost:3000/api';
  static String socketUrl = Platform.isAndroid  ? 'http://127.0.0.1:3000' : 'http://localhost:3000';
  
  // static String apiUrl    = Platform.isAndroid  ? 'http://31.220.31.215:3000/api' : 'http://31.220.31.215:3000/api';
  // static String socketUrl = Platform.isAndroid  ? 'http://31.220.31.215:3000' : 'http://31.220.31.215:3000';
}