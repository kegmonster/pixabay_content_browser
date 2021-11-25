import 'package:flutter/material.dart';

abstract class BaseItem{
  String fileName = '';
  Size resolution = Size(0,0);
  String id = '';
  DateTime creationDate = DateTime(0);
  IconData iconData = Icons.help_outline;
  String url = '';

  BaseItem.fromJson(Map<String, dynamic> json){
    id = json['id'].toString();
  }

}
