import 'package:flutter/material.dart';
import 'package:photo_filter_app/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:photo_filter_app/models/image_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider( 
      create: (context) => ImageModel(),
      child: MaterialApp(
        title: 'Photo Filter App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}