import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:markazeh/screens/login_screen.dart';

Widget drawer(context) {
  return Drawer(
    backgroundColor: Colors.grey[900],
    child: Column(
      children: [
        // Logo Header
        Padding(
          padding: EdgeInsets.only(top: 60.h),
          child: Container(
            color: Colors.grey[900],
            padding: EdgeInsets.symmetric(vertical: 20.h),
            width: double.infinity,
            child: Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: 300.w,
                height: 300.h,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),

        ListTile(
          leading: Image.asset(
            'assets/images/setting.png',
            width: 100.w,
            height: 100.h,
          ),
          title: Text(
            'Kiosk Settings ',
            style: TextStyle(color: Colors.white, fontSize: 40.sp),
          ),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Login()),
            );
          },
        ),

        Spacer(),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 50.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Check for updates',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35.sp,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.grey[100], // force underline color
                  decorationThickness: 1, // make it clearly visible
                ),
              ),
              SizedBox(height: 30.h),
              Text(
                'Version 24.08.1',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 30.sp),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
