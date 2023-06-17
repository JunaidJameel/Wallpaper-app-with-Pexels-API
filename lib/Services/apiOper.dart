import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wallpaper/Model/photosModel.dart';

class ApiOperations {
  static List<PhotosModel> searchWallpapersList = [];

  static String _apiKey =
      "563492ad6f91700001000001e1ddd92e4ccc4c7c8ba25e98235577c4";

  static int page = 1;
  static Future<List<PhotosModel>> searchWallpapers(String query) async {
    await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=$query&per_page=80&page=1"),
        headers: {"Authorization": "$_apiKey"}).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];
      searchWallpapersList.clear();
      photos.forEach((element) {
        searchWallpapersList.add(PhotosModel.fromAPI2App(element));
      });
    });

    return searchWallpapersList;
  }
}
