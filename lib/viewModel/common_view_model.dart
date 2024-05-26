import 'dart:convert';

import 'package:eventmanagement/model/response/my_booking_response.dart';
import 'package:eventmanagement/model/response/my_booking_response.dart';
import 'package:eventmanagement/model/response/my_booking_response.dart';
import 'package:eventmanagement/model/response/my_booking_response.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_response.dart';
import '../api/repositories/user_repository.dart';
import '../helper/custom_loader.dart';
import '../model/response/event_response.dart';

class CommonViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _connected = false;
  bool get connnected => _connected;

  bool _showDot = false;
  bool get showDot => _showDot;

  bool _hasData = false;
  bool get hasData => _hasData;

  bool _hasStudent = false;
  bool get hasStudent => _hasStudent;

  setHasStudent(bool value) {
    _hasStudent = value;
    notifyListeners();
  }

  setIfData(bool value) {
    _hasData = value;
    notifyListeners();
  }

  setDot(bool state) {
    _showDot = state;
    notifyListeners();
  }

  bool _assignedDot = false;
  bool get assignedDot => _assignedDot;

  setAssignedDot(bool value) {
    _assignedDot = value;
    notifyListeners();
  }

  bool _academicDot = false;
  bool get academicDot => _academicDot;

  SetAcademicDot(bool value) {
    _assignedDot = value;
    notifyListeners();
  }

  setLoading(bool state) {
    _isLoading = state;
    notifyListeners();
  }

  BuildContext? _context;

  void setContext(BuildContext context) {
    _context = context;
  }


  //student navigation

  int _navigatoinIndex = 0;
  int get navigatoinIndex => _navigatoinIndex;

  PageController _pagecontroller = PageController();
  PageController get pagecontroller => _pagecontroller;
  setNavigationIndex(int index) {
    _navigatoinIndex = index;
    notifyListeners();
  }

  setInitial(int index) {
    _pagecontroller = PageController(initialPage: index);
    setNavigationIndex(index);
    notifyListeners();
  }

  itemTapped(int index) {
    setNavigationIndex(index);
    _pagecontroller.jumpToPage(index);
    notifyListeners();
  }

  ApiResponse _eventDataApiResponse = ApiResponse.initial("Empty Data");
  ApiResponse get eventDataApiResponse => _eventDataApiResponse;
  EventResponse _eventData = EventResponse();
  EventResponse get eventData => _eventData;

  Future<void> fetchEvent(String search) async {
    _eventDataApiResponse = ApiResponse.initial("Loading");
    notifyListeners();
    try {
      EventResponse res = await UserRepository().getEventData(search);
      if (res.success == true) {
        _eventData = res;

        _eventDataApiResponse = ApiResponse.completed(res.success.toString());
        notifyListeners();
      } else {
        _eventDataApiResponse = ApiResponse.error(res.success.toString());
      }
    } catch (e) {
      print("VM CATCH ERR :: " + e.toString());
      _eventDataApiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }


  ApiResponse _myBookingApiResponse = ApiResponse.initial("Empty Data");
  ApiResponse get myBookingApiResponse => _myBookingApiResponse;
  MyBookingResponse _myBooking = MyBookingResponse();
  MyBookingResponse get myBooking => _myBooking;

  Future<void> fetchMyBooking() async {
    _myBookingApiResponse = ApiResponse.initial("Loading");
    notifyListeners();
    try {
      MyBookingResponse res = await UserRepository().getBooking();
      if (res.success == true) {
        _myBooking = res;

        _myBookingApiResponse = ApiResponse.completed(res.success.toString());
        notifyListeners();
      } else {
        _myBookingApiResponse = ApiResponse.error(res.success.toString());
      }
    } catch (e) {
      print("VM CATCH ERR :: " + e.toString());
      _myBookingApiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }
}


class DashboardData {
  String? image;
  Function()? onTap;

  DashboardData({this.image, this.onTap});
}
