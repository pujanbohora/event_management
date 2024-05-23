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
  Future getData(String apiUrl) async {
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(api_url2 + apiUrl), headers: _setHeader());
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

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

  Future putWithToken(apiUrl) async {
    dynamic responseJson;
    var token = localStorage.getString('token');

    try {
      final response = await http.put(Uri.parse(api_url2 + apiUrl), headers: {
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

  Future deleteWithToken(apiUrl) async {
    print("[DELETE] :: " + api_url2 + apiUrl);
    dynamic responseJson;
    // print(api_url2 + apiUrl);

    // print(api_url2 + apiUrl);
    var token = localStorage.getString('token');
    try {
      final response =
          await http.delete(Uri.parse(api_url2 + apiUrl), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'platform': EnvironmentConfig.platform,
      });
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future postDataAsWeb(data, apiUrl) async {
    // print("[POST WEB] :: " + api_url2 + apiUrl);
    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(api_url2 + apiUrl),
              body: data, headers: _setHeaderAsWeb())
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

  Future<dynamic> postChat(dynamic map) async {
    try {
      return await http
          .post(Uri.parse('http://45.115.219.218:5006/webhooks/rest/webhook'),
              headers: {
                'Content-Type': 'application/json; charset=utf-8',
              },
              body: jsonEncode(map))
          .then((data) {
        // print(data.body);
        if (data.statusCode == 200) {
          final response = jsonDecode(data.body);

          return response;
        } else {
          return "n/a";
        }
      }).catchError((e) {
        print(e.toString());
        return "n/a";
      });
    } on SocketException catch (e) {
      print(e);
      return "n/a";
    } on HttpException {
      return "n/a";
    } on FormatException {
      return "n/a";
    }
  }


  Future<dynamic> postChatLecturer(dynamic map) async {
    try {
      return await http
          .post(Uri.parse('https://chat.teacher.schoolworkspro.com/webhooks/rest/webhook'),
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
          },
          body: jsonEncode(map))
          .then((data) {
        // print(data.body);
        if (data.statusCode == 200) {
          final response = jsonDecode(data.body);

          return response;
        } else {
          return "n/a";
        }
      }).catchError((e) {
        print(e.toString());
        return "n/a";
      });
    } on SocketException catch (e) {
      print(e);
      return "n/a";
    } on HttpException {
      return "n/a";
    } on FormatException {
      return "n/a";
    }
  }


  Future<dynamic> postChatAdmin(dynamic map) async {
    try {
      return await http
          .post(Uri.parse('https://chat.superadmin.schoolworkspro.com/webhooks/rest/webhook'),
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
          },
          body: jsonEncode(map))
          .then((data) {
        if (data.statusCode == 200) {
          final response = jsonDecode(data.body);

          return response;
        } else {
          return "n/a";
        }
      }).catchError((e) {
        print(e.toString());
        return "n/a";
      });
    } on SocketException catch (e) {
      print(e);
      return "n/a";
    } on HttpException {
      return "n/a";
    } on FormatException {
      return "n/a";
    }
  }
  Future putData(data, apiUrl) async {
    print("[POST] :: " + api_url2 + apiUrl);
    dynamic responseJson;
    try {
      final response = await http
          .put(Uri.parse(api_url2 + apiUrl), body: data, headers: _setHeader())
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

  Future postDataFast(data, apiUrl) async {
    print("[POST] :: " + api_url2 + apiUrl);
    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(api_url2 + apiUrl), body: data, headers: _setHeader())
          .timeout(
        const Duration(seconds: 2),
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

  Future postDataWithHeader(data, apiUrl) async {
    print("[POST] :: " + api_url2 + apiUrl);
    dynamic responseJson;
    try {
      final response = await http.post(Uri.parse(api_url2 + apiUrl),
          body: data, headers: _setHeaders());
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

  Future postDataWithTokenAsWeb(data, apiUrl) async {
    dynamic responseJson;

    print("[POST] :: " + api_url2 + apiUrl);
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

  Future putDataWithToken(data, apiUrl) async {
    dynamic responseJson;

    print("[PUTTT] :: " + api_url2 + apiUrl);
    if (localStorage.containsKey('token')) {
      var token = localStorage.getString('token');

      try {
        final response = await http.put(
          Uri.parse(api_url2 + apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
            'platform': EnvironmentConfig.platform,
          },
          body: data,
        );

        print("STATUS CODE::: ${response.statusCode}");

        responseJson = returnResponse(response);
      } on SocketException {
        throw FetchDataException('No Internet Connection');
      }
      return responseJson;
    } else {
      return putData(data, apiUrl);
    }
  }

  Future postDataWithTokenAndFiles(
      data, apiUrl, List<Map<String, List<String>>> images) async {
    dynamic responseJson;
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': "Bearer " + token.toString(),
      'platform': EnvironmentConfig.platform,
    };
    var request = http.MultipartRequest("POST", Uri.parse(api_url2 + apiUrl));

    var _image = File(images[0]['files']![0].toString());

    String name = images[0].toString().split("/").last.toString();
    String name1 = name.split("]").first.toString();

    request.fields.addAll(data);

    request.files.add(http.MultipartFile.fromBytes(
        'file',
        await File.fromUri(Uri.parse(images[0]['files']![0].toString()))
            .readAsBytes(),
        contentType: MediaType(
          'pdf',
          'doc',
        ),
        filename: name1));

    request.headers.addAll(headers);
    try {
      final response = await request.send();
      responseJson = await http.Response.fromStream(response);
      responseJson = returnResponse(responseJson);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future postDataWithTokenAndOnlyFiles(String images, String filename) async {
    dynamic responseJson;
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': "Bearer " + token.toString(),
      'platform': EnvironmentConfig.platform,
    };
    var request = http.MultipartRequest("POST",
        Uri.parse("https://api.schoolworkspro.com/contents/upload-file"));

    print("IMage" + images.toString());
    print("\n\n");

    request.files.add(http.MultipartFile.fromBytes(
        'file', await File.fromUri(Uri.parse(images)).readAsBytes(),
        contentType: MediaType('pdf', 'doc'), filename: filename));

    request.headers.addAll(headers);
    try {
      final response = await request.send();
      responseJson = await http.Response.fromStream(response);
      responseJson = returnResponse(responseJson);
      print("RESPONSE:::${responseJson.toString()}");
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future postDataWithTokenAndpickedimage(data, apiUrl, PickedFile file) async {
    dynamic responseJson;

    var token = localStorage.getString('token');

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'platform': EnvironmentConfig.platform,
    };

    var request = http.MultipartRequest("POST", Uri.parse(api_url2 + apiUrl));
    request.fields.addAll(data);
    request.files.add(http.MultipartFile.fromBytes(
        'file', await File.fromUri(Uri.parse(file.path)).readAsBytes(),
        contentType: MediaType('image', 'jpg'), filename: 'image.jpg'));

    request.headers.addAll(headers);
    try {
      final response = await request.send();
      responseJson = await http.Response.fromStream(response);
      responseJson = returnResponse(responseJson);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future deleteDataWithToken(apiUrl) async {
    print("[DELETE] :: " + api_url2 + apiUrl);
    dynamic responseJson;
    var token = localStorage.getString('token');
    try {
      final response =
          await http.delete(Uri.parse(api_url2 + apiUrl), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'platform': EnvironmentConfig.platform,
      });
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  _setHeaders() => {
        'Content-Type': 'application/json;charset=UTF-8',
        'Charset': 'utf-8',
        'platform': EnvironmentConfig.platform,
      };

  _setHeader() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'platform': EnvironmentConfig.platform,
      };

  _setHeaderAsWeb() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "platform": "web"
      };

  logout() async {
    localStorage.remove('user');
    localStorage.remove('token');
    localStorage.remove('displayShowcase');
  }

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
