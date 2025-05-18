import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gif/gif.dart';
import 'package:markazeh/screens/choose_branch.dart';
import 'package:markazeh/widgets/app_bar.dart';
import 'package:markazeh/widgets/drawer.dart';

class ChooseLanguage extends StatefulWidget {
  const ChooseLanguage({super.key});

  @override
  State<ChooseLanguage> createState() => _ChooseLanguageState();
}

class _ChooseLanguageState extends State<ChooseLanguage>
    with SingleTickerProviderStateMixin {
  late final GifController controller;

  @override
  void initState() {
    controller = GifController(vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: drawer(context),
      body: Center(
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              child: Gif(
                image: AssetImage("assets/images/background.gif"),
                controller:
                    controller, // if duration and fps is null, original gif fps will be used.
                //fps: 30,
                //duration: const Duration(seconds: 3),
                autostart: Autostart.loop,
                fit: BoxFit.cover,
                placeholder: (context) => const Text('Loading...'),
                onFetchCompleted: () {
                  controller.reset();
                  controller.forward();
                },
              ),
            ),
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  appBar(),
                  SizedBox(width: 300.w),
                  Builder(
                    builder: (scaffoldContext) => IconButton(
                      color: Colors.white,
                      icon: const Icon(Icons.menu),
                      onPressed: () {
                        Scaffold.of(scaffoldContext).openEndDrawer();
                      },
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                mainAxisSize:
                    MainAxisSize.min, // shrink column height to content
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Please choose the language",
                    style: TextStyle(
                      fontSize: 35.sp, // bigger font size
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "الرجاء اختيار اللغة",
                    style: TextStyle(
                      fontSize: 35.sp, // bigger font size
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          // English selected
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white
                              .withOpacity(0.2), // light gray transparent
                          padding: EdgeInsets.symmetric(
                              vertical: 14.h, horizontal: 50.w),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          "English",
                          style: TextStyle(
                            fontSize: 24.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 20.h),
                      TextButton(
                        onPressed: () {
                          // Arabic selected
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white
                              .withOpacity(0.2), // light gray transparent
                          padding: EdgeInsets.symmetric(
                              vertical: 14.h, horizontal: 50.w),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          "العربية",
                          style: TextStyle(
                            fontSize: 24.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 50.h,
              left: 100.w,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChooseBranch(
                              isFromLogin: true,
                            )),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0x1AFFFFFF), // Gray background
                  foregroundColor: Colors.white, // White text

                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5), // Radius 2
                  ),
                ),
                child: Text(
                  'back',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
