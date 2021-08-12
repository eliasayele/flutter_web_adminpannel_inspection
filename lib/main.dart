import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inspection_admin/constants.dart';
import 'package:inspection_admin/controllers/FilterProvider.dart';
import 'package:inspection_admin/controllers/MenuController.dart';
import 'package:inspection_admin/controllers/PageController.dart';
import 'package:inspection_admin/screens/main/main_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'controllers/AppState.dart';
import 'controllers/FilterNotifieer.dart';
import 'locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.]
  var from = locator<FilterNotifier>().from;
  var to = locator<FilterNotifier>().to;

  // 2021-08-11 23:12:28.455
  // 2021-09-01T08:57:35.827Z
  @override
  Widget build(BuildContext context) {
    print("//// this is first page");
    DateTime now = DateTime.now();
    now = DateTime(now.year, now.month - 1, now.day);
    print(now);
    print(now.toUtc().toIso8601String());
    // print(DateTime.now().toUtc().toIso8601String());
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    // print(formattedDate);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Car Inspection',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => MenuController()),
          ChangeNotifierProvider(create: (context) => PageControl()),
          ChangeNotifierProvider(create: (context) => AppState()),
          ChangeNotifierProvider(create: (context) => FilterProvider()),
        ],
        child: GestureDetector(
            onTap: () {
              ///this code basically does when user taps in screen body it
              ///will un focus the textField
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus!.unfocus();
              }
            },
            child: MainScreen()),
      ),
    );
  }
}
