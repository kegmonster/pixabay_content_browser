import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class Authentication extends ChangeNotifier{

  bool _isLoggedIn = false;
  String email = '';

  dynamic validatePassword(String password){
    //> 8 lowercase, uppercase, number, specialc
    //split the validation so we get specific feedback
    if (password.length < 8){
      return 'Password too short';
    }
    else if(!RegExp('.*[a-z]').hasMatch(password)){
      return 'At least one lowercase character';
    }
    else if(!RegExp('.*[A-Z]').hasMatch(password)){
      return 'At least one uppercase character';
    }
    else if(!RegExp('.*[0-9]').hasMatch(password)){
      return 'At least one numeric character';
    }
    else if(!RegExp('.*[!@#\$%^&*()]').hasMatch(password)){
      return 'At least one special character';
    }
    else{
      return null;
    }
  }

  dynamic validateEmail(String email){
    if(EmailValidator.validate(email)){
      return null;
    }
    else {
      return 'Please enter a valid email';
    }
  }

  void signIn(String email, String pw){
    _isLoggedIn = true;
    //as long as the username and password is valid, this is a valid login
    notifyListeners();
  }

  bool get isLoggedIn {
    return _isLoggedIn;
  }
  set isLoggedIn(bool value){
    _isLoggedIn = value;
    notifyListeners();
  }
}