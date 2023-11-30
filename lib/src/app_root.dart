import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ketaby/Views/main_screan.dart';
import 'package:ketaby/Views/register_screan.dart';

import '../Views/login_screan.dart';
Color mainColor = Color(0xFF30B0B3);



class MyApp extends StatelessWidget {

  Widget? widget;
   MyApp({super.key, this.widget});




  // This widget is the root of your application.
  @override
  Widget build(BuildContext context)  {



    return MaterialApp(

        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
        ).copyWith(
          primaryColor: mainColor,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          textTheme: TextTheme(
            labelLarge: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: mainColor,
            ),
            labelMedium: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            labelSmall: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
            bodyLarge: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal,
              color: mainColor,
            ),
            bodyMedium: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
            bodySmall: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.grey,
            ),

          ),
          useMaterial3: true,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: mainColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              fixedSize: Size(300, 50),


            ),

          ),
          iconTheme: IconThemeData(
            color: mainColor,
          ),
          iconButtonTheme: IconButtonThemeData(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(mainColor),
              )
          ),

          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            selectedItemColor: mainColor,
            unselectedItemColor: Colors.grey,
          ),

        ),
        home: widget
    );
  }
}