import 'package:flutter/material.dart';
import 'package:pixabay_content_browser/models/base_item.dart';

class VideoItem extends BaseItem{
  IconData iconData = Icons.ondemand_video_outlined;
  String videoUrl = '';
  VideoItem.fromJson(Map<String,dynamic> json) : super.fromJson(json){

    url = 'https://i.vimeocdn.com/video/'+ json['picture_id'] +'_640x360.jpg';

    videoUrl = json['videos']['medium']['url'];
    resolution = _getResolution(json['videos']);
    fileName = json['id'].toString();
    creationDate = _getCreationDateFromUrl(json['userImageURL']);
  }

  DateTime _getCreationDateFromUrl(String url) {
    if (url.isNotEmpty) {
      List<String> segments = Uri.parse(url).pathSegments;
      int year = int.parse(segments[segments.length - 4]);
      int month = int.parse(segments[segments.length - 3]);
      int day = int.parse(segments[segments.length - 2]);
      return DateTime(year, month, day);
    }else{
      return DateTime(0,0,0);
    }
  }

  Size _getResolution(Map<String, dynamic> json){
    if (json['large']['url'] != '') {
      return Size(json['large']['width'].toDouble(), json['large']['height'].toDouble());
    }
    else{
      return Size(json['medium']['width'].toDouble(), json['medium']['height'].toDouble());
    }
  }
}