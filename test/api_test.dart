import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:pixabay_content_browser/models/image_item.dart';
import 'package:pixabay_content_browser/models/video_item.dart';

void main(){

  test("Api test images", () async{
    Client client = Client();

    String API_KEY = '24484916-0948d19eda371407c3d8e4f09';
    var resp = await client.get(
        Uri.https(
            'pixabay.com','api',
            {'key':API_KEY, 'q': 'flowers', 'per_page' : '50'})
    );
    print(resp.statusCode);
    Map<String, dynamic> data = jsonDecode(resp.body);
    List<dynamic> results = data['hits'];
    results.forEach((element) {
      ImageItem item = ImageItem.fromJson(element);
      print(item.creationDate);
    });

  });

  test("Api test videos", () async{
    Client client = Client();

    String API_KEY = '24484916-0948d19eda371407c3d8e4f09';
    var resp = await client.get(Uri.https('pixabay.com','api/videos', {'key':API_KEY, 'q': 'flowers'}));
    print(resp.statusCode);
    Map<String, dynamic> data = jsonDecode(resp.body);
    List<dynamic> results = data['hits'];
    results.forEach((element) {
      //print(element);
      VideoItem item = VideoItem.fromJson(element);
      print(item.fileName);
    });

  });
}