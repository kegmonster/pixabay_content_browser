import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pixabay_content_browser/providers/authentication.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget{
  final Authentication auth;

  LoginPage(this.auth);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginPageState();
  }

}

class LoginPageState extends State<LoginPage>{

  bool _showPassword = false;
  String _email = '';
  String _password = '';
  final _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(child: Image.asset('assets/wings.png', fit: BoxFit.contain,)),
          Padding(
            padding: const EdgeInsets.only(left:8.0, right:8.0, bottom: 24 ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Email'
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => widget.auth.validateEmail(value!),
                    onSaved: (value) => _email = value!,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(_showPassword ? Icons.visibility_off : Icons.visibility),
                        onPressed: (){
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                      )
                    ),
                    validator: (value) => widget.auth.validatePassword(value!),
                    obscureText: !_showPassword,
                    onSaved: (value) => _password = value!,
                  ),
                  TextButton(onPressed: (){
                    if (_formKey.currentState!.validate()){
                      _formKey.currentState!.save();
                      widget.auth.signIn(_email, _password);
                    }
                  }, child: Text('Login')),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

}