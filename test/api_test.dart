import 'dart:convert';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:pixabay_content_browser/models/image_item.dart';
import 'package:pixabay_content_browser/models/video_item.dart';
import 'package:pixabay_content_browser/providers/pixabay_api_provider.dart';

void main(){
  Client client = Client();

  String API_KEY = '24484916-0948d19eda371407c3d8e4f09';
  test("API call failure", () async{
    PixabayAPIProvider provider = new PixabayAPIProvider(client, 'bad key');
    expect(() => provider.fetchImageItems('something', '1'), throwsException);
  });

  test("Test known api image decoding", () async {
    var resp = await client.get(
        Uri.https('pixabay.com', 'api', {'key': API_KEY, 'id': '195893'}));
    Map<String, dynamic> data = jsonDecode(resp.body);
    List<dynamic> results = data['hits'];
    results.forEach((element) {
      ImageItem item = ImageItem.fromJson(element);
      expect(item.fileName, 'flower-195893_150.jpg');
      expect(item.creationDate, DateTime(2013, 10, 15));
      expect(item.resolution, Size(4000.0, 2250.0));
    });
  });

  test('Test hardcoded sample image decoding',() async{
    Map<String, dynamic> data = {
      "total": 1,
      "totalHits": 1,
      "hits": [
        {
          "id": 195893,
          "pageURL": "https://pixabay.com/photos/blossom-bloom-flower-yellow-195893/",
          "type": "photo",
          "tags": "blossom, bloom, flower",
          "previewURL": "https://cdn.pixabay.com/photo/2013/10/15/09/12/flower-195893_150.jpg",
          "previewWidth": 150,
          "previewHeight": 84,
          "webformatURL": "https://pixabay.com/get/gc9e7fca56f0ff4899722b9328d6def90685d8d8180d26622b2a068c38a2192b24960548457360738a9e673c34010f393_640.jpg",
          "webformatWidth": 640,
          "webformatHeight": 360,
          "largeImageURL": "https://pixabay.com/get/gbfb94199b2e9aa883086e13908f2c13c58dddba54dcaff8ae06184451fc30f575139a7ae869aa05344479831587b125cc0140f7cb84adcf603b16fc44eb59c8d_1280.jpg",
          "imageWidth": 4000,
          "imageHeight": 2250,
          "imageSize": 1637207,
          "views": 34404,
          "downloads": 11616,
          "collections": 69,
          "likes": 66,
          "comments": 8,
          "user_id": 48777,
          "user": "Josch13",
          "userImageURL": "https://cdn.pixabay.com/user/2013/11/05/02-10-23-764_250x250.jpg"
        }
      ]
    };
    List<dynamic> results = data['hits'];
    results.forEach((element) {
      ImageItem item = ImageItem.fromJson(element);
      expect(item.fileName, 'flower-195893_150.jpg');
      expect(item.creationDate, DateTime(2013, 10, 15));
      expect(item.resolution, Size(4000.0, 2250.0));
    });
  });

  test("Test known api video decoding", () async {
    var resp = await client.get(
        Uri.https('pixabay.com', 'api/videos', {'key': API_KEY, 'id': '1044'}));
    Map<String, dynamic> data = jsonDecode(resp.body);
    List<dynamic> results = data['hits'];
    results.forEach((element) {
      VideoItem item = VideoItem.fromJson(element);
      expect(item.fileName, '1044');
      expect(item.creationDate, DateTime(2015, 10, 16));
      expect(item.resolution, Size(1920.0, 1080.0));
    });
  });

  test("Test hardcoded sample video decoding", (){
    Map<String, dynamic> sample = {"total": 1,
      "totalHits": 1,
      "hits": [
        {
          "id": 1044,
          "pageURL": "https://pixabay.com/videos/id-1044/",
          "type": "film",
          "tags": "new york city,manhattan,people",
          "duration": 14,
          "picture_id": "539965294-5d28c268c602aa5173006fa74acb94671783ba702dc2892682e897c8a158af75-d",
          "videos": {
            "large": {
              "url": "https://player.vimeo.com/external/142621375.hd.mp4?s=8044ebbcf4941ace7497b75d848a96cb1a70e416&profile_id=119",
              "width": 1920,
              "height": 1080,
              "size": 5883475
            },
            "medium": {
              "url": "https://player.vimeo.com/external/142621375.hd.mp4?s=8044ebbcf4941ace7497b75d848a96cb1a70e416&profile_id=113",
              "width": 1280,
              "height": 720,
              "size": 3743582
            },
            "small": {
              "url": "https://player.vimeo.com/external/142621375.sd.mp4?s=bd35defa4994849004de45d0f594fb622144ecb1&profile_id=112",
              "width": 640,
              "height": 360,
              "size": 1290734
            },
            "tiny": {
              "url": "https://player.vimeo.com/external/142621375.mobile.mp4?s=e9a3c9616798b6f3d074d579ea8314acc75fad72&profile_id=116",
              "width": 480,
              "height": 270,
              "size": 529535
            }
          },
          "views": 138023,
          "downloads": 68403,
          "likes": 302,
          "comments": 82,
          "user_id": 1281706,
          "user": "Coverr-Free-Footage",
          "userImageURL": "https://cdn.pixabay.com/user/2015/10/16/09-28-45-303_250x250.png"
        }
      ]
    };
    List<dynamic> results = sample['hits'];
    results.forEach((element) {
    VideoItem item = VideoItem.fromJson(element);
    expect(item.fileName, '1044');
    expect(item.creationDate, DateTime(2015, 10, 16));
    expect(item.resolution, Size(1920.0, 1080.0));
    });
  });
}