import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gif/gif.dart';
import 'package:markazeh/models/get_settings_response.dart';
import 'package:markazeh/screens/setting.dart';
import 'package:markazeh/services/all_services.dart';
import 'package:markazeh/widgets/app_bar.dart';
import 'package:provider/provider.dart';

class ServicesSetting extends StatefulWidget {
  const ServicesSetting({super.key});

  @override
  State<ServicesSetting> createState() => _ServicesSettingState();
}

class _ServicesSettingState extends State<ServicesSetting>
    with SingleTickerProviderStateMixin {
  late final GifController controller;

  // simple on/off state for the three switches
  final Map<int, bool> _switches = {0: false, 1: false, 2: false};

  final _labels = [
    'Service controls',
    'Branch selection',
    'Sign out',
  ];

  @override
  void initState() {
    controller = GifController(vsync: this);
    Provider.of<AllServices>(context, listen: false).getSettingsBybranchId(
        Provider.of<AllServices>(context, listen: false).branchId!);
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
      body: Stack(
        children: [
          Positioned.fill(
            child: Gif(
              image: const AssetImage('assets/images/background.gif'),
              controller: controller,
              autostart: Autostart.loop,
              fit: BoxFit.cover,
              placeholder: (_) => const Center(child: Text('Loading…')),
              onFetchCompleted: () {
                controller
                  ..reset()
                  ..forward();
              },
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                appBar(),

                // ServicesSettings list
                Provider.of<AllServices>(context).settingsResponse == null
                    ? Container()
                    : Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.only(top: 16.h),
                          itemCount: Provider.of<AllServices>(context)
                              .settingsResponse!
                              .data
                              .services
                              .length,
                          itemBuilder: (context, index) {
                            return _ServicesSettingsTile(
                                Provider.of<AllServices>(context)
                                    .settingsResponse!
                                    .data
                                    .services[index]);
                          },
                        ),
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
                  MaterialPageRoute(builder: (context) => const Setting()),
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
          Positioned(
            bottom: 50.h,
            right: 100.w,
            child: ElevatedButton(
              onPressed: () {
                for (int i = 0;
                    Provider.of<AllServices>(context, listen: false)
                            .settingsResponse!
                            .data
                            .services
                            .length >
                        i;
                    i++) {
                  Provider.of<AllServices>(context, listen: false)
                      .updateBranchServiceStatus(
                          Provider.of<AllServices>(context, listen: false)
                              .settingsResponse!
                              .data
                              .services[i],
                          Provider.of<AllServices>(context, listen: false)
                              .branchId!);
                }
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
                'save',
                style: TextStyle(fontSize: 12),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _ServicesSettingsTile(Services item) {
    return ListTile(
      leading: Image.asset(
        'assets/images/setting.png',
        width: 100.w,
        height: 100.h,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
      title: Text(
        item.serviceNameEn,
        style: TextStyle(
          color: Colors.white,
          fontSize: 40.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Switch(
        value: item.isEnabled,
        activeColor: Colors.white,
        inactiveTrackColor: Colors.white38,
        onChanged: (val) => setState(() => item.isEnabled = val),
      ),
      onTap: () => setState(() {
        // optional: tapping the row toggles the switch too
        item.isEnabled = !item.isEnabled;
        Provider.of<AllServices>(context, listen: false)
            .settingsResponse!
            .data
            .services
            .firstWhere((element) => element.serviceId == item.serviceId)
            .isEnabled = item.isEnabled;
      }),
    );
  }
}
