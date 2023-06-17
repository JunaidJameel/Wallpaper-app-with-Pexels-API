import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wallpaper/Wallpaper.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100.h,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'images/s.png',
                ),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Download and Set\nAmazing Wallpapers',
              style: GoogleFonts.rubik(
                  color: Colors.amber,
                  fontSize: 24.5.sp,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 3.h,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Wallpaper(),
                    ));
              },
              child: Row(
                children: [
                  SizedBox(
                    width: 6.w,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 101, 255, 106),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                      child: Row(
                        children: [
                          Text(
                            'Get Started',
                            style: GoogleFonts.rubik(
                                color: Colors.black,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Image.asset(
                            'images/next.png',
                            height: 3.5.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
          ],
        ),
      ),
    );
  }
}
