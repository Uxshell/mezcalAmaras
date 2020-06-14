import 'package:flutter/material.dart';

import 'package:mezcalamaras/src/bloc/provider.dart';

import 'package:mezcalamaras/src/pages/home_page.dart';
import 'package:mezcalamaras/src/pages/login_page.dart';
import 'package:mezcalamaras/src/pages/contacto_page.dart';

 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Amores',
        initialRoute: 'login',
        routes: {
          'login'    : ( BuildContext context ) => LoginPage(),
          'home'     : ( BuildContext context ) => HomePage(),
          'contacto' : ( BuildContext context ) => ContactoPage(),
        },
        theme: ThemeData(
          primaryColor: Color.fromRGBO(139, 109, 68, 1),
        ),
      ),
    );
      
  }
}