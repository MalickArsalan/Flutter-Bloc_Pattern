import 'package:flutter/material.dart';
import 'package:my_photos/src/ui/album_list.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      home: Scaffold(
        body: AlbumList(),
      ),
    );
  }
}
