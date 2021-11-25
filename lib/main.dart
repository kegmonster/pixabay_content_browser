import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixabay_content_browser/UI/home_page.dart';
import 'package:pixabay_content_browser/UI/login_page.dart';
import 'package:pixabay_content_browser/providers/authentication.dart';
import 'package:provider/provider.dart';

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
              return HomePage(title: 'Home', authentication: auth);
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






