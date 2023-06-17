import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart ' as http;
import 'package:lottie/lottie.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wallpaper/FullScreen.dart';

import 'package:wallpaper/search.dart';

class Wallpaper extends StatefulWidget {
  const Wallpaper({super.key});

  @override
  State<Wallpaper> createState() => _HomeState();
}

class _HomeState extends State<Wallpaper> {
  FocusNode focusNode = FocusNode();
  List images = [];
  int page = 1;
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    focusNode.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchapi();
    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle(
    //     systemNavigationBarColor: Color.fromARGB(255, 22, 21, 21),
    //     systemNavigationBarIconBrightness: Brightness.dark,
    //   ),
    // );
  }

  bool isLoading = true;
  fetchapi() async {
    var url =
        'https://api.pexels.com/v1/curated?per_page=80&page=$page'; // default url

    final response = await http.get(Uri.parse(url), headers: {
      'Authorization':
          '563492ad6f91700001000001e1ddd92e4ccc4c7c8ba25e98235577c4'
    });
    setState(() {
      isLoading = false;
    });
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      setState(() {
        if (page == 1) {
          images = result['photos']; // first page data
        } else {
          images.addAll(result['photos']); // append next page data
        }
      });
    } else {
      throw Exception('Failed to load images');
    }
  }

  loadMore() {
    page++;
    fetchapi();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: const Text('Do you want to Exit?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text(
                    'Yes',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text(
                    'No',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 22, 21, 21),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.5.w),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              if (focusNode.hasFocus) {
                focusNode.unfocus();
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 4.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 2.w),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 3.h),
                        child: Text(
                          'Redux',
                          style: GoogleFonts.carterOne(
                            color: Color.fromARGB(255, 75, 255, 81),
                            fontWeight: FontWeight.w700,
                            letterSpacing: 5,
                            fontSize: 25.sp,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Lottie.network(
                        'https://assets5.lottiefiles.com/packages/lf20_qwl4gi2d.json',
                        height: 10.h,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 2.h, top: 3.h),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1.w),
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            border:
                                Border.all(color: Color.fromARGB(33, 13, 5, 5)),
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                          child: Row(
                            children: [
                              Image.asset(
                                'images/search.png',
                                height: 4.h,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Expanded(
                                child: TextField(
                                  focusNode: focusNode,
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w500),
                                  controller: searchController,
                                  decoration: InputDecoration(
                                    hintText: "Search Wallpapers",
                                    hintStyle: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w400),
                                    errorBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              InkWell(
                                  onTap: () {
                                    if (searchController.text.isNotEmpty) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SearchScreen(
                                              query: searchController.text),
                                        ),
                                      );
                                    }
                                  },
                                  child: const Icon(
                                    Icons.send,
                                    color: Color.fromARGB(255, 129, 246, 133),
                                  ))
                            ],
                          ),
                        )),
                  ),
                ),
                isLoading == true
                    ? Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: Center(
                          child:
                              const Center(child: CircularProgressIndicator()),
                        ),
                      )
                    : Expanded(
                        child: GridView.builder(
                            itemCount: images.length + 1,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 0,
                              childAspectRatio: 1.9 / 3,
                              mainAxisSpacing: 2,
                            ),
                            itemBuilder: (context, index) {
                              if (index == images.length) {
                                return MaterialButton(
                                  onPressed: loadMore(),
                                  child: Center(
                                    child: index == 0
                                        ? Container()
                                        : const CircularProgressIndicator(),
                                  ),
                                );
                              }
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FullScreen(
                                            imagesurl: images[index]['src']
                                                ['large2x']),
                                      ));
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.black,
                                      image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                          images[index]['src']['large'],
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                SizedBox(
                  height: 2.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
