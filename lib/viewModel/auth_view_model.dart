import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/api_response.dart';
import '../api/repositories/user_repository.dart';
import '../config/preference_utils.dart';
import '../model/response/common_response.dart';

class AuthViewModel with ChangeNotifier {

  ApiResponse _registerUserApiResponse = ApiResponse.initial("Empty Data");
  ApiResponse get registerUserApiResponse => _registerUserApiResponse;
  CommonResponse _registerUser = CommonResponse();
  CommonResponse get registerUser => _registerUser;

  Future<void> register(data) async {
    _registerUserApiResponse = ApiResponse.initial("Loading");
    notifyListeners();
    try {
      CommonResponse res = await UserRepository().registerUser(data);
      if (res.success == true) {
        _registerUser = res;

        _registerUserApiResponse = ApiResponse.completed(res.success.toString());
        notifyListeners();
      } else {
        _registerUserApiResponse = ApiResponse.error(res.success.toString());
      }
    } catch (e) {
      print("VM CATCH ERR :: " + e.toString());
      _registerUserApiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }
}
