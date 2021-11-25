import 'package:flutter/material.dart';
import 'package:pixabay_content_browser/UI/widgets/image_item.dart';
import 'package:pixabay_content_browser/UI/widgets/video_item.dart';
import 'package:pixabay_content_browser/models/base_item.dart';
import 'package:pixabay_content_browser/models/image_item.dart';
import 'package:pixabay_content_browser/models/video_item.dart';
import 'package:pixabay_content_browser/providers/folder_content_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class FolderPage extends StatefulWidget{
  final String name;
  final FolderContentProvider contentProvider;
  FolderPage(this.name) : contentProvider = FolderContentProvider(name);

  @override
  FolderPageState createState() => FolderPageState();
}

class FolderPageState extends State<FolderPage> {

  static const int SCROLL_THRESHOLD = 5;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.contentProvider.fetchMoreItems();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider<FolderContentProvider>.value(
      value: widget.contentProvider,
      child: Consumer<FolderContentProvider>(
          builder: (_,contentProvider,__) {
            return Scaffold(
                appBar: AppBar(
                  title: Text(widget.name),
                  actions: [
                    PopupMenuButton<SortBy>(
                        itemBuilder: (context) {
                          return SortBy.values.map((e) {
                            return PopupMenuItem<SortBy>(value: e, child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(sortByLookup(e)),
                                e == contentProvider.sortOrder ?
                                Icon(Icons.check, color: Color.fromARGB(255, 0x00, 0x19, 0x43)):
                                Container()
                              ],
                            ),);
                          }).toList();
                        },
                        icon: Icon(Icons.sort),
                        onSelected: (choice) {
                          widget.contentProvider.sortOrder = choice;
                          widget.contentProvider.sort(choice);
                        }
                    ),
                  ],
                ),
                body: ListView.builder(
                    itemCount: contentProvider.baseItems.length +
                        (contentProvider.hasMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (contentProvider.lastError != '') {
                        return Text('Failed: ' + contentProvider.lastError);
                      }
                      else {
                        if (index ==
                            contentProvider.baseItems.length -
                                SCROLL_THRESHOLD) {
                          contentProvider.fetchMoreItems();
                        }
                        if (index == contentProvider.baseItems.length) {
                          print(contentProvider.hasMore);
                          if (contentProvider.hasMore) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(child: CircularProgressIndicator(
                                  color: Color.fromARGB(
                                      255, 0x00, 0x19, 0x43))),
                            );
                          }
                          else {
                            return Container();
                          }
                        }
                        else {
                          return buildItem(contentProvider.baseItems[index]);
                        }
                      }
                    }
                )
            );
          }
        ),
      );

  }

  Widget buildItem(BaseItem item){
    return Card(
      margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
      child: ListTile(
        leading: Container(
          height:double.infinity,
            child: Icon(item.iconData, size: 32, color: Color.fromARGB(255, 0x00, 0x19, 0x43),)),
        title: Text(item.fileName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${item.resolution.width.toStringAsFixed(0)}x${item.resolution.height.toStringAsFixed(0)}' ),
            item.creationDate.year > 0 ? Text(DateFormat.yMd().format(item.creationDate)) : Container(),
          ],
        ),
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    content: Container(
                      child: item is ImageItem ? ImageItemPreview(item)
                          : VideoItemPreview(item as VideoItem),
                    ));
              }
          );
        },
      ),
    );
  }
}


