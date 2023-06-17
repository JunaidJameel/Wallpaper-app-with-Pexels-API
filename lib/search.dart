import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wallpaper/FullScreen.dart';
import 'package:wallpaper/Wallpaper.dart';

import 'package:wallpaper/Services/apiOper.dart';
import 'package:wallpaper/Model/photosModel.dart';

class SearchScreen extends StatefulWidget {
  String query;
  SearchScreen({super.key, required this.query});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}
w
class _SearchScreenState extends State<SearchScreen> {
  late List<PhotosModel> searchResults;
  bool isLoading = true;
  GetSearchResults() async {
    searchResults = await ApiOperations.searchWallpapers(widget.query);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetSearchResults();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 22, 21, 21),
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 9.h,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.only(top: 6.h),
          child: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Wallpaper(),
                  ));
            },
            child: Row(
              children: [
                Image.asset(
                  'images/back.png',
                  color: Color.fromARGB(255, 25, 232, 32),
                ),
              ],
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 23, 22, 22),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.5.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 4.h,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 90.h,
                      child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          childAspectRatio: 1.5 / 3,
                          mainAxisSpacing: 20,
                        ),
                        itemCount: searchResults.length,
                        itemBuilder: ((context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FullScreen(
                                          imagesurl:
                                              searchResults[index].imgSrc)));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        searchResults[index].imgSrc),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
