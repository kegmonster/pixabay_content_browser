import 'package:flutter/material.dart';
import 'package:pixabay_content_browser/models/base_item.dart';

class ImageItem extends BaseItem{
  IconData iconData = Icons.image;

  ImageItem.fromJson(Map<String,dynamic> json) : super.fromJson(json){
    //print(json['previewURL']);
    url = json['previewURL'];
    resolution = Size(json['imageWidth'].toDouble(), json['imageHeight'].toDouble());
    fileName = _getFileNameFromURL(json['previewURL']);
    creationDate = _getCreationDateFromUrl(json['previewURL']);
  }

  String _getFileNameFromURL(String url) {
    if (url.isNotEmpty) {
      return Uri.parse(url).pathSegments.last;
    }
    else{
      return 'no_name';
    }
  }

  DateTime _getCreationDateFromUrl(String url) {
    if(url.isNotEmpty) {
      List<String> segments = Uri.parse(url).pathSegments;
      int year = int.parse(segments[segments.length - 6]);
      int month = int.parse(segments[segments.length - 5]);
      int day = int.parse(segments[segments.length - 4]);
      return DateTime(year, month, day);
    }
    else{
      return DateTime(0,0,0);
    }
  }
}