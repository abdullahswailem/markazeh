import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gif/gif.dart';
import 'package:markazeh/screens/setting.dart';
import 'package:markazeh/services/all_services.dart';
import 'package:markazeh/widgets/app_bar.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  late final GifController controller;

  final TextEditingController employeeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                padding: EdgeInsets.symmetric(horizontal: 100.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Label for Employee Number
                      Text(
                        'Employee Number',
                        style: TextStyle(color: Colors.white, fontSize: 40.sp),
                      ),
                      SizedBox(height: 30.h),
                      TextFormField(
                        controller: employeeController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Enter your employee number',
                          hintStyle: const TextStyle(color: Colors.white70),
                          filled: true,
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          fillColor:
                              Colors.transparent, // transparent background
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Employee number cannot be empty';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 70.h),

                      // Label for Password
                      Text(
                        'Password',
                        style: TextStyle(color: Colors.white, fontSize: 40.sp),
                      ),
                      SizedBox(height: 30.h),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          hintText: 'Enter your password',
                          hintStyle: const TextStyle(color: Colors.white70),
                          filled: true,
                          fillColor:
                              Colors.transparent, // transparent background
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Employee number cannot be empty';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 50.h,
              right: 100.w,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Provider.of<AllServices>(context, listen: false)
                        .login(employeeController.text, passwordController.text)
                        .then((value) {
                      if (value == true) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Setting()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Invalid employee number or password'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    });
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
                child: Provider.of<AllServices>(context).loading == true
                    ? CircularProgressIndicator()
                    : Text(
                        'Confirm',
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
