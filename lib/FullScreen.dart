import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wallpaper/Services/BottomSheet.dart';

class FullScreen extends StatefulWidget {
  final String imagesurl;
  FullScreen({super.key, required this.imagesurl});

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 5.h,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Image.asset(
                      'images/back.png',
                      color: Color.fromARGB(255, 129, 246, 133),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              SizedBox(
                height: 71.h,
                width: 100.w,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.network(
                      widget.imagesurl,
                      fit: BoxFit.cover,
                    )),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  Get.bottomSheet(
                    BottomSheett(
                      imagesurl: widget.imagesurl,
                    ),
                  );
                },
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 1.h),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: const Color.fromARGB(255, 129, 246, 133),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 2.h),
                        child: Text(
                          'Set Wallpaper',
                          style: GoogleFonts.poppins(
                              fontSize: 23,
                              color: Colors.black,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
