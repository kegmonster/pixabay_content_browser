import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixabay_content_browser/UI/login_page.dart';
import 'package:pixabay_content_browser/providers/authentication.dart';
import 'package:provider/provider.dart';

import 'UI/folder_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  final Authentication auth = Authentication();
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Redbull Pixabay Browser',
      theme: ThemeData(
        // This is the theme of your application.
          primaryColor: Color.fromARGB(255, 0xEC, 0x3D, 0x67),
          splashColor: Color.fromARGB(255, 0xEC, 0x3D, 0x67),
          fontFamily: GoogleFonts.cairo().fontFamily,
          primarySwatch: createMaterialColor(Color.fromARGB(255, 0x00, 0x19, 0x43)),
          accentColor: Color.fromARGB(255, 0xEC, 0x3D, 0x67),
          iconTheme: IconThemeData(
              color: Color.fromARGB(255, 0x00, 0x19, 0x43),//Color.fromARGB(255, 0, 0, 51),
          ),

      ),
      home: ChangeNotifierProvider<Authentication>.value(
        value: widget.auth,
        child: Consumer<Authentication>(
          builder: (_, auth, __){
            if (auth.isLoggedIn){
              return MyHomePage(title: 'Home', authentication: auth);
            }
            else{
              return LoginPage(auth);
            }
          },
        ),
      )
    );
  }

  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title, required this.authentication}) : super(key: key);

  final String title;
  final Authentication authentication;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<String> folders = [
    'Clouds',
    'Cars',
    'Urban',
    'besem',
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
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
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
        // todo: dynamically change the crossaxis count based on orientation
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
            folders.add('extra');
          });
        },
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<Widget> _createFolders(List<String> names) {
    return names.map((name) =>
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: InkWell(
            onTap: ()=> onFolderClick(name),
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
        )
    ).toList();
  }

  void onFolderClick(String folder){
    Navigator.push(context, MaterialPageRoute(builder: (context) => FolderPage(folder)));
    print(folder);
  }
}




