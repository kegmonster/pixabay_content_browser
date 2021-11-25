import 'package:flutter/material.dart';
import 'package:pixabay_content_browser/UI/folder_page.dart';
import 'package:pixabay_content_browser/providers/authentication.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title, required this.authentication}) : super(key: key);

  final String title;
  final Authentication authentication;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //this is just seed data
  List<String> folders = [
    'Clouds',
    'Cars',
    'Urban',
    'guys',
    'laptop',
    'crown'
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([]);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(icon: Icon(Icons.logout), onPressed: () async{
            var result = await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  content: Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(child: Text('No'), onPressed: () => Navigator.pop(context, false),),
                    TextButton(child: Text('Yes'), onPressed: () => Navigator.pop(context, true),),
                  ],
                );
              },
            );
            if (result){
              widget.authentication.isLoggedIn = false;
            }
          },),
        ],
      ),
      body: Center(
          child: OrientationBuilder(
              builder: (context, orientation) {
                return GridView.count(
                  padding: EdgeInsets.all(4.0),
                  crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
                  children: _createFolders(folders),
                );
              }
          )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            //todo: get new folder name
            folders.add('extra');
          });
        },
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<Widget> _createFolders(List<String> names) {
    return names.map((name) => createFolderWidget(name)).toList();
  }

  Widget createFolderWidget(String name){
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: InkWell(
        onTap: ()=> onFolderWidgetClick(name),
        child: Column(
          children: [
            Expanded(child: FittedBox(child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(Icons.folder,),
            ), fit: BoxFit.fill)),
            Padding(
              padding: const EdgeInsets.only(bottom:8.0),
              child: Text(name, overflow: TextOverflow.ellipsis,),
            ),
          ],
        ),
      ),
    );
  }

  void onFolderWidgetClick(String folder){
    Navigator.push(context, MaterialPageRoute(builder: (context) => FolderPage(folder)));
  }
}