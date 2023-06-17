import 'package:flutter/material.dart';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

class BottomSheett extends StatefulWidget {
  final String imagesurl;
  const BottomSheett({super.key, required this.imagesurl});

  @override
  State<BottomSheett> createState() => _BottomSheettState();
}

class _BottomSheettState extends State<BottomSheett> {
  Future<void> setwallpaper() async {
    try {
      int location = WallpaperManager.HOME_SCREEN;
      var file = await DefaultCacheManager().getSingleFile(widget.imagesurl);

      final bool result =
          await WallpaperManager.setWallpaperFromFile(file.path, location);
    } catch (e) {
      print('Got an Error on SetWallpaper Function');
    }
  }

  // lock Screen
  Future<void> setwallpaperLockScreen() async {
    try {
      int location = WallpaperManager.LOCK_SCREEN;
      var file = await DefaultCacheManager().getSingleFile(widget.imagesurl);

      bool result =
          await WallpaperManager.setWallpaperFromFile(file.path, location);
    } catch (e) {
      print('Got an Error on SetWallpaper Function');
    }
  }

  Future<void> SaveImageToGallery() async {
    try {
      GallerySaver.saveImage(widget.imagesurl, albumName: 'WallPaper')
          .then((value) {
        Fluttertoast.showToast(
            msg: 'WallPaper Downloaded ', gravity: ToastGravity.CENTER);
      });
    } catch (e) {
      print('Image is not Download');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: 100.w,
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: Container(
              height: 0.7.h,
              width: 15.w,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
            ),
          ),
          Text(
            'What would you like to do?',
            style: GoogleFonts.rubik(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 21.sp,
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          InkWell(
            onTap: () {
              setwallpaper();
              Navigator.pop(context);
              Fluttertoast.showToast(
                  msg: 'WallPaper Updated', gravity: ToastGravity.CENTER);
            },
            child: ListTile(
              leading: Icon(Icons.image),
              title: Text(
                'Set Wallpaper to Home Screen',
                style: GoogleFonts.rubik(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setwallpaperLockScreen();
              Navigator.pop(context);
              Fluttertoast.showToast(
                  msg: 'WallPaper Updated', gravity: ToastGravity.CENTER);
            },
            child: ListTile(
              leading: const Icon(Icons.screen_lock_landscape),
              title: Text(
                'Set Wallpaper to Lock Screen',
                style: GoogleFonts.rubik(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 19.sp,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              SaveImageToGallery();
              Navigator.pop(context);

              Fluttertoast.showToast(
                  msg: 'WallPaper Downloading ...',
                  gravity: ToastGravity.CENTER);
            },
            child: ListTile(
              leading: Icon(Icons.download),
              title: Text(
                'Download Wallpaper',
                style: GoogleFonts.rubik(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 19.5.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
