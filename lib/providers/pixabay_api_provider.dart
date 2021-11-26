import 'dart:convert';

import 'package:http/http.dart';
import 'package:pixabay_content_browser/models/base_item.dart';
import 'package:pixabay_content_browser/models/image_item.dart';
import 'package:pixabay_content_browser/models/video_item.dart';

class PixabayAPIProvider{
  final String api_key;// = '24484916-0948d19eda371407c3d8e4f09';
  final String _host = 'pixabay.com';
  final Client client;
  static const int PAGE_SIZE = 25;

  PixabayAPIProvider(this.client,this.api_key);

  Future<List<ImageItem>> fetchImageItems(String searchTerm, String page) async {
    var resp = await client.get(Uri.https(_host,'api',
        {
          'key':api_key,
          'q': searchTerm,
          'per_page': PAGE_SIZE.toString(),
          'page' : page,
        }));
    if (resp.statusCode != 200){
      throw Exception(resp.body);
    }
    Map<String, dynamic> data = jsonDecode(resp.body);
    List<dynamic> results = data['hits'];
    List<ImageItem> items = [];
    results.forEach((element) {
      ImageItem item = ImageItem.fromJson(element);
      items.add(item);
    });
    return items;
  }

  Future<List<VideoItem>> fetchVideoItems(String searchTerm, String page) async {
    var resp = await client.get(Uri.https(_host,'api/videos',
        {
          'key': api_key,
          'q': searchTerm,
          'per_page': PAGE_SIZE.toString(),
          'page' : page
        })
    );
    if (resp.statusCode != 200){
      throw Exception(resp.body);
    }
    Map<String, dynamic> data = jsonDecode(resp.body);
    List<dynamic> results = data['hits'];
    List<VideoItem> items = [];
    results.forEach((element) {
      VideoItem item = VideoItem.fromJson(element);
      items.add(item);
    });
    return items;
  }

  Future<List<BaseItem>> fetchItems(String searchTerm, String page) async {
    List<BaseItem> items = [];
    List<BaseItem> images= await fetchImageItems(searchTerm, page);
    items.addAll(images);
    List<BaseItem> videos = await fetchVideoItems(searchTerm, page);
    items.addAll(videos);
    return items;
  }


}