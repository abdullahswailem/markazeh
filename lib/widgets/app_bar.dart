import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget appBar() {
  return Container(
    height: 100.h,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/logo.png',
          width: 200.h,
          height: 200.w,
        ),
      ],
    ),
  );
}
