
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/video_list_model.dart';

class VideoListController extends GetxController {
  var videoListModel = VideoListModel().obs;
  var isLoading = true.obs;

  Future<void> fetchVideoList(int movieId) async {
    try {
      isLoading(true);

      final response = await http.get(
        Uri.parse('https://api.themoviedb.org/3/movie/$movieId/videos?api_key=155bf92a0cb4adca560b4b5f213dacfa'),
      );

      if (response.statusCode == 200) {
        print("printing statuscode for videolistapi = ${response.statusCode}");

        videoListModel(VideoListModel.fromJson(json.decode(response.body)));

        print("printing video key = ${videoListModel.value.results![0].key}");

      } else {
        // Handle error, you can show a snackbar or log the error
        print('Error: ${response.statusCode}');
      }
    } finally {
      isLoading(false);
    }
  }

  String? getFirstVideoKey() {
    if (videoListModel.value.results != null && videoListModel.value.results!.isNotEmpty) {
      print("printing key = ${videoListModel.value.results![0].key}");
      return videoListModel.value.results![0].key;
    }
    return null;
  }
}
