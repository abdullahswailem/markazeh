import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gif/gif.dart';
import 'package:markazeh/screens/choose_language.dart';
import 'package:markazeh/screens/setting.dart';
import 'package:markazeh/services/all_services.dart';
import 'package:markazeh/widgets/app_bar.dart';
import 'package:provider/provider.dart';

class ChooseBranch extends StatefulWidget {
  final bool isFromLogin;
  const ChooseBranch({this.isFromLogin = false, super.key});

  @override
  State<ChooseBranch> createState() => _ChooseBranchState();
}

class _ChooseBranchState extends State<ChooseBranch>
    with SingleTickerProviderStateMixin {
  late final GifController controller;
  bool oneTime = true;
  int? selectedBranch;

  bool _isDropdownOpen = false;
  @override
  void initState() {
    Provider.of<AllServices>(context, listen: false).getAllBranches();
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
    if (widget.isFromLogin == false) {
      setState(() {
        if (oneTime == true) {
          selectedBranch = Provider.of<AllServices>(context).branchId;
          oneTime = false;
        }
      });
    }
    return Scaffold(
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
              child: appBar(),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Please choose the branch',
                              style: TextStyle(
                                fontSize: 25.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Provider.of<AllServices>(context).branches == null
                                ? Container(
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : DropdownButtonFormField2<int>(
                                    value: selectedBranch,
                                    isExpanded: true,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 16),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 0.5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 0.5),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 0.5),
                                      ),
                                    ),
                                    hint: const Text(
                                      'Select Your branch ',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                    items: Provider.of<AllServices>(context)
                                        .branches!
                                        .data
                                        .map((item) => DropdownMenuItem<int>(
                                              value: item.id,
                                              child: Text(
                                                item.branchNameEn,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please select gender.';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        selectedBranch = value as int?;
                                      });
                                    },
                                    onMenuStateChange: (isOpen) {
                                      setState(() {
                                        _isDropdownOpen = isOpen;
                                      });
                                    },
                                    onSaved: (value) {
                                      selectedBranch = value as int?;
                                    },
                                    buttonStyleData: const ButtonStyleData(
                                      padding: EdgeInsets.only(right: 8),
                                    ),
                                    iconStyleData: IconStyleData(
                                      icon: AnimatedRotation(
                                        turns: _isDropdownOpen ? 0.5 : 0.0,
                                        duration:
                                            const Duration(milliseconds: 200),
                                        child: const Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: Colors.white,
                                        ),
                                      ),
                                      iconSize: 24,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      decoration: BoxDecoration(
                                        color: Colors
                                            .black, // black menu background
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            widget.isFromLogin == true
                ? Container()
                : Positioned(
                    bottom: 50.h,
                    left: 100.w,
                    child: ElevatedButton(
                      onPressed: () {
                        Provider.of<AllServices>(context, listen: false)
                            .branchId = selectedBranch;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Setting()),
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
            selectedBranch == null
                ? Container()
                : Positioned(
                    bottom: 50.h,
                    right: 100.w,
                    child: ElevatedButton(
                      onPressed: () {
                        Provider.of<AllServices>(context, listen: false)
                            .branchId = selectedBranch!;
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ChooseLanguage()));
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
                        'Sign In',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
