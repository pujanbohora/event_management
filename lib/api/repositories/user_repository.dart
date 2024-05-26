import 'dart:convert';
import 'package:eventmanagement/model/response/event_response.dart';

import 'package:eventmanagement/model/response/event_response.dart';

import 'package:eventmanagement/model/response/event_response.dart';

import 'package:eventmanagement/model/response/event_response.dart';

import '../../model/response/common_response.dart';
import '../../model/response/login_response.dart';
import '../../model/response/my_booking_response.dart';
import '../api.dart';

class UserRepository {
  API api = API();

  Future<CommonResponse> registerUser(data) async {
    dynamic response;
    CommonResponse res;
    try {
      response = await api.postData(data, "/verification/signup");
      res = CommonResponse.fromJson(response);
    } catch (e) {
      res = CommonResponse.fromJson(response);
    }
    return res;
  }

  Future<LoginResponse> loginUser(data) async {
    dynamic response;
    LoginResponse res;
    try {
      response = await api.postData(data, "/verification/login");
      res = LoginResponse.fromJson(response);
    } catch (e) {
      res = LoginResponse.fromJson(response);
    }
    return res;
  }

  Future<LoginResponse> fetchEvents(data) async {
    dynamic response;
    LoginResponse res;
    try {
      response = await api.postData(data, "/verification/login");
      res = LoginResponse.fromJson(response);
    } catch (e) {
      res = LoginResponse.fromJson(response);
    }
    return res;
  }

  Future<EventResponse> getEventData(search) async {
    dynamic response;
    EventResponse res;
    try {
      response = await api.getWithToken( search == "" ? "/events" : "/events/?title=$search");
      res = EventResponse.fromJson(response);
    } catch (e) {
      res = EventResponse.fromJson(response);
    }
    return res;
  }

  Future<CommonResponse> addBooking(data) async {
    dynamic response;
    CommonResponse res;
    try {
      response = await api.postDataWithToken(data, "/booking/book-an-event");
      res = CommonResponse.fromJson(response);
    } catch (e) {
      res = CommonResponse.fromJson(response);
    }
    return res;
  }

  Future<MyBookingResponse> getBooking() async {
    dynamic response;
    MyBookingResponse res;
    try {
      response = await api.getWithToken("/booking/mine");
      res = MyBookingResponse.fromJson(response);
    } catch (e) {
      res = MyBookingResponse.fromJson(response);
    }
    return res;
  }

  Future<CommonResponse> logOutUser() async {
    dynamic response;
    CommonResponse res;
    try {
      response = await api.getWithToken( "/verification/logout");
      res = CommonResponse.fromJson(response);
    } catch (e) {
      res = CommonResponse.fromJson(response);
    }
    return res;
  }
}
