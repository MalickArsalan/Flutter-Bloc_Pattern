import 'package:flutter/material.dart';
import '../models/albums.dart';
import '../blocs/albums_bloc.dart';
import 'photo_list.dart';

class AlbumList extends StatefulWidget {
  AlbumList({Key key}) : super(key: key);

  @override
  _AlbumListState createState() => _AlbumListState();
}

class _AlbumListState extends State<AlbumList> {
  @override
  void initState() {
    super.initState();
    bloc.fetchAllAlbums();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Favourite Albums'),
      ),
      body: StreamBuilder<List<AlbumModel>>(
        stream: bloc.allAlbums,
        builder: (context, AsyncSnapshot<List<AlbumModel>> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot.data);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget buildList(List<AlbumModel> albums) {
    return ListView.builder(
      //itemCount: albums.length,
      padding: EdgeInsets.all(8.0),
      itemBuilder: (BuildContext context, int index) {
        if (index.isOdd) return Divider();

        final albumIndex = index ~/ 2;

        return (albumIndex <= albums.length - 1)
            ? buildRow(context, albums[albumIndex])
            : null;
      },
    );
  }

  Widget buildRow(BuildContext context, AlbumModel album) {
    return ListTile(
      title: Text(
        (album.id).toString() + '. ' + album.title,
        style: TextStyle(fontSize: 16.0),
      ),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        // print('Id: ' + album.id.toString() + '   Title: ' + album.title);
        openPhotoPage(context, album.id, album.title);
      },
    );
  }
}

openPhotoPage(BuildContext context, int albumId, String albumTitle) {
  print('Id: $albumId    Title: $albumTitle');

  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) {
      return PhotoList(albumId: albumId, albumTitle: albumTitle);
    }),
  );
}
