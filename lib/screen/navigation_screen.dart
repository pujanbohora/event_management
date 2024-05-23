
import 'dart:io';
import 'dart:math';

import 'package:eventmanagement/screen/home_screen.dart';
import 'package:eventmanagement/screen/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import '../../constants/text_style.dart';
import '../constants/colors.dart';
import '../viewModel/common_view_model.dart';
import 'my_booking_screen.dart';

class Navigation extends StatefulWidget {
  final int currentIndex;
  const Navigation({Key? key, required this.currentIndex}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  String title = 'Home';

  late CommonViewModel commonViewModel;

  @override
  void initState() {

    commonViewModel = Provider.of<CommonViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    commonViewModel.fetchEvent();
    commonViewModel.fetchMyBooking();
    });


    super.initState();
  }

  _onPageChanged(int index) {
    setState(() {
      commonViewModel.setNavigationIndex(index);
      switch (index) {
        case 0:
          {
            title = 'Home';
          }
          break;
        case 1:
          {
            title = 'My Booking';
          }
          break;
        case 2:
          {
            title = 'Setting';
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (commonViewModel.navigatoinIndex == 0) {
          Navigator.of(context).popUntil((route) => route.isFirst);
          return Future.value(false);
        } else {
          commonViewModel.itemTapped(0);
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Scaffold(
        body: PageView(
          controller: commonViewModel.pagecontroller,
          onPageChanged: _onPageChanged,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            HomeScreen(),
            MyBookingHistoryScreen(),
            SettingScreen(),
          ],
        ),
        bottomNavigationBar:
            Consumer<CommonViewModel>(builder: (context, common, child) {
          return BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: commonViewModel.navigatoinIndex,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black,
            unselectedLabelStyle: p13.copyWith(
                fontWeight: FontWeight.w800, color: Colors.grey.shade800),
            selectedLabelStyle: p13.copyWith(
                fontWeight: FontWeight.w800, color: Colors.grey.shade800),
            onTap: commonViewModel.itemTapped,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                    padding: const EdgeInsets.all(8),
                    height: 40,
                    width: 40,
                    // color: logoTheme,
                    child: const Icon(Icons.home)),
                label: "Home",
                activeIcon: Container(
                    padding: const EdgeInsets.all(8),
                    height: 40,
                    width: 40,
                    child: const Icon(
                      Icons.home_filled,
                      color: logoTheme,
                    )),
              ),
              BottomNavigationBarItem(
                icon: Container(
                    padding: const EdgeInsets.all(8),
                    height: 40,
                    width: 40,
                    child: const Icon(Icons.camera_alt)),
                label: "My Bookings",
                activeIcon: Container(
                    height: 40,
                    padding: const EdgeInsets.all(8),
                    width: 40,
                    child: const Icon(
                      Icons.video_camera_front_rounded,
                      color: logoTheme,
                    )),
              ),
              BottomNavigationBarItem(
                icon: Container(
                    height: 40,
                    padding: const EdgeInsets.all(8),
                    width: 40,
                    child: const Icon(Icons.settings)),
                label: "Setting",
                activeIcon: Container(
                    height: 40,
                    padding: const EdgeInsets.all(8),
                    width: 40,
                    child: const Icon(
                      Icons.settings,
                      color: logoTheme,
                    )),
              ),
            ],
          );
        }),
      ),
    );
  }
}
