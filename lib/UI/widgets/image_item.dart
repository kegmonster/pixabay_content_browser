import 'package:flutter/material.dart';
import 'package:pixabay_content_browser/models/image_item.dart';

class ImageItemPreview extends StatelessWidget{
  final ImageItem item;
  ImageItemPreview(this.item);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: EdgeInsets.all(2.0),
        title: Image.network(item.url, fit: BoxFit.fill,),
        subtitle: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(item.fileName, overflow: TextOverflow.ellipsis,),
            SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 3,
                child: Image(image: AssetImage('assets/pixalbay_logo.png'),
                  fit: BoxFit.fill,)),
          ],
        ));
  }

}
