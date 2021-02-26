import 'package:flutter/cupertino.dart';

class AuthModel extends ChangeNotifier {
  String _token = '';

  String get latestToken => _token;

  void updateToken(String token){
    _token = token;
    notifyListeners();
  }

}