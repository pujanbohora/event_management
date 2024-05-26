import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import '../config/environment.config.dart';
import '../config/preference_utils.dart';
import 'api_exception.dart';

String api_url2 = EnvironmentConfig.url;

class API {
  final SharedPreferences localStorage = PreferenceUtils.instance;

  Future getWithToken(apiUrl) async {
    print("[GET] :: " + api_url2 + apiUrl);
    dynamic responseJson;
    var token = localStorage.getString('token');

    print("TOKEN:::$token");

    try {
      final response = await http.get(Uri.parse(api_url2 + apiUrl), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'platform': EnvironmentConfig.platform,
      });
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } catch (e) {
    }
    return responseJson;
  }

  Future postData(data, apiUrl) async {
    print("[POST] :: " + api_url2 + apiUrl);
    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(api_url2 + apiUrl), body: data, headers: _setHeader())
          .timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          // Time has run out, do what you wanted to do.
          throw FetchDataException('No Internet Connection');
        },
      );
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future postDataWithToken(data, apiUrl) async {
    dynamic responseJson;

    print("[POST] :::: " + api_url2 + apiUrl);
    if (localStorage.containsKey('token')) {
      var token = localStorage.getString('token');
      print(token.toString());
      try {
        final response = await http.post(
          Uri.parse(api_url2 + apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
            'platform': EnvironmentConfig.platform,
          },
          body: data,
        );

        responseJson = returnResponse(response);
      } on SocketException {
        throw FetchDataException('No Internet Connection');
      }

      return responseJson;
    } else {
      return postData(data, apiUrl);
    }
  }

  _setHeader() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'platform': EnvironmentConfig.platform,
      };


  @visibleForTesting
  dynamic returnResponse(http.Response response) {
    print("STATUS CODE :: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        responseJson["STATUS_CODE"] = response.statusCode.toString();
        return responseJson;
      case 201:
        dynamic responseJson = jsonDecode(response.body);
        responseJson["STATUS_CODE"] = response.statusCode.toString();
        return responseJson;
      case 301:
      case 302:
        dynamic responseJson = jsonDecode(response.body);
        responseJson["STATUS_CODE"] = response.statusCode.toString();
        return responseJson;
      case 400:
        dynamic responseJson = jsonDecode(response.body);
        try {
          if (responseJson["success"] != null ||
              responseJson["message"] != null) {
            return responseJson;
          } else {
            throw BadRequestException(response.body.toString());
          }
        } catch (e) {
          throw BadRequestException(response.body.toString());
        }

      case 401:
      case 403:
        dynamic responseJson = jsonDecode(response.body);
        if (responseJson["success"] != null || responseJson["message"] != null) {
          return responseJson;
        } else {
          throw UnauthorisedException(response.body.toString());
        }
      case 404:
        dynamic responseJson = jsonDecode(response.body);
        print("404 ERR :: " + responseJson.toString());
        if (responseJson["success"] != null || responseJson["message"] != null) {
          return responseJson;
        } else {
          throw BadRequestException(response.body.toString());
        }
      case 406:
        dynamic responseJson = jsonDecode(response.body);
        responseJson["STATUS_CODE"] = response.statusCode.toString();
        if (responseJson["success"] != null) {
          return responseJson;
        } else {
          throw BadRequestException(response.body.toString());
        }
      case 409:
        dynamic responseJson = jsonDecode(response.body);
        responseJson["STATUS_CODE"] = response.statusCode.toString();
        if (responseJson["message"] != null || responseJson["success"] != null) {
          return responseJson;
        } else {
          throw BadRequestException(response.body.toString());
        }
      case 429:
        dynamic responseJson = jsonDecode(response.body);
        responseJson["STATUS_CODE"] = response.statusCode.toString();
        if (responseJson["message"] != null || responseJson["success"] != null) {
          return responseJson;
        } else {
          throw BadRequestException(response.body.toString());
        }
      case 501:
        dynamic responseJson = jsonDecode(response.body);
        responseJson["STATUS_CODE"] = response.statusCode.toString();
        if (responseJson["message"] != null || responseJson["success"] != null) {
          return responseJson;
        } else {
          throw BadRequestException(response.body.toString());
        }
      case 500:
        dynamic responseJson = jsonDecode(response.body);
        responseJson["STATUS_CODE"] = response.statusCode.toString();
        if (responseJson["message"] != null ||
            responseJson["success"] != null) {
          return responseJson;
        } else {
          throw BadRequestException(response.body.toString());
        }
      default:
        try {
          print(response.body.toString());
        } catch (e) {}
        throw FetchDataException(
            'Error occured while communication with server' +
                ' with status code : ${response.statusCode}');
    }
  }
}
