import 'package:flutter/material.dart';
import 'package:pixabay_content_browser/models/video_item.dart';
import 'package:video_player/video_player.dart';

class VideoItemPreview extends StatefulWidget{
  final VideoItem item;
  VideoItemPreview(this.item);

  @override
  _VideoItemPreviewState createState() => _VideoItemPreviewState();
}

class _VideoItemPreviewState extends State<VideoItemPreview> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        widget.item.videoUrl)
      ..initialize().then((_) {

        setState(() {
          _controller.play();
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0.0),
      dense: true,
      title: _controller.value.isInitialized ?
      AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller)
      )
          :Image.network(widget.item.url, fit: BoxFit.fill),
      subtitle: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.item.fileName, overflow: TextOverflow.clip,),
          SizedBox(
              width: MediaQuery.of(context).size.width/3,
              child: Image(image: AssetImage('assets/pixalbay_logo.png'), fit: BoxFit.fill,)),
        ],
      ),
      onTap: () {
        if (_controller.value.isInitialized) {
          if(_controller.value.isPlaying){
            _controller.pause();
          }
          else{
            _controller.play();
          }
        }
      },
    );

  }
}