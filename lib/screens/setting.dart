import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gif/gif.dart';
import 'package:markazeh/screens/choose_branch.dart';
import 'package:markazeh/screens/services_setting.dart';
import 'package:markazeh/services/all_services.dart';
import 'package:markazeh/widgets/app_bar.dart';
import 'package:provider/provider.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> with SingleTickerProviderStateMixin {
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
      body: Center(
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              child: Gif(
                image: AssetImage("assets/images/background.gif"),
                controller: controller,
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
              child: Column(
                children: [
                  appBar(),
                  _item('Service controls', () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ServicesSetting()),
                    );
                  }),
                  _item('branch selection', () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChooseBranch(
                                isFromLogin: false,
                              )),
                    );
                  }),
                  _item('sign out', () {
                    Provider.of<AllServices>(context, listen: false)
                        .clearData();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChooseBranch(
                                isFromLogin: true,
                              )),
                    );
                  }),
                ],
              ),
            ),

            // … inside your Stack, just above the closing ],
          ],
        ),
      ),
    );
  }
}

Widget _item(String label, VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40.h),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 50.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 40.h),
          Divider(
            color: Colors.white,
            thickness: 0.8,
            height: 0,
          ),
        ],
      ),
    ),
  );
}
