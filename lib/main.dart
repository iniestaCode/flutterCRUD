import 'package:consultorio_crud/src/bloc/provider.dart';
import 'package:consultorio_crud/src/pages/home_page.dart';
//import 'package:consultorio_crud/src/pages/login_page.dart';
import 'package:consultorio_crud/src/pages/people_page.dart';
import "package:flutter/material.dart";

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Provider(
      child:MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material',
      initialRoute: 'home',
      darkTheme: ThemeData.dark(),
      routes:{
        //'login' : (context)=>LoginPage(),
        'home'  : (context)=>HomePage(),
        'people': (context)=>PeoplePage(),
        },
    )
    );
    
    
    
  }
}

