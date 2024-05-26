import 'dart:convert';
import 'dart:io';

import 'package:eventmanagement/routes/route_generator.dart';
import 'package:eventmanagement/viewModel/auth_view_model.dart';
import 'package:eventmanagement/viewModel/common_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:provider/provider.dart';
import 'config/environment.config.dart';
import 'config/preference_utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  await EnvironmentConfig().init();
  await PreferenceUtils.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OverlayKit(
      child: MultiProvider(
          providers: [
            ChangeNotifierProvider<CommonViewModel>(
              create: (_) => CommonViewModel(),
            ),
            ChangeNotifierProvider<AuthViewModel>(
              create: (_) => AuthViewModel(),
            ),
          ],
          child: MaterialApp(
            title: 'eventManagement',
            initialRoute: '/',
            onGenerateRoute: RouteGenerator.generateRoute,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                appBarTheme: const AppBarTheme(
                    backgroundColor: Colors.transparent,
                    iconTheme: IconThemeData(
                      color: Colors.black,
                    ),
                    centerTitle: false, elevation: 0, shadowColor: Colors.transparent),
                scaffoldBackgroundColor: const Color(0xFFD4D4F7),
                primaryColor: Color(0XFF6A62B7),
                // fontFamily: "Muli",
                // textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme)),
                textTheme: const TextTheme(
                    bodyText1: TextStyle(color: Colors.black),
                    bodyText2: TextStyle(color: Colors.black))),
            // home: Splashscreen()
          )),
    );
  }
}
