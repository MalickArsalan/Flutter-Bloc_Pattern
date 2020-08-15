import 'package:flutter/material.dart';
import '../models/photos.dart';
import '../blocs/photos_bloc.dart';

class PhotoList extends StatefulWidget {
  final int albumId;
  final String albumTitle;

  const PhotoList({Key key, this.albumId, this.albumTitle}) : super(key: key);

  @override
  _PhotoListState createState() => _PhotoListState(
        albumId: albumId,
        albumTitle: albumTitle,
      );
}

class _PhotoListState extends State<PhotoList> {
  final int albumId;
  final String albumTitle;

  @override
  void initState() {
    super.initState();
    bloc.fetchAllPhotos(albumId);
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  _PhotoListState({this.albumId, this.albumTitle});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(albumTitle),
      ),
      body: StreamBuilder(
        stream: bloc.allPhotos,
        builder: (context, AsyncSnapshot<List<PhotoModel>> snapshot) {
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
}

Widget buildList(List<PhotoModel> photos) {
  return GridView.builder(
    itemCount: photos.length,
    padding: EdgeInsets.all(8.0),
    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
    ),
    itemBuilder: (BuildContext context, int index) {
      print(index);
      return index < photos.length ? buildTile(photos[index]) : null;
    },
  );
}

Widget buildTile(PhotoModel photo) {
  return GridTile(
      child: Image.network(
    photo.url,
    fit: BoxFit.cover,
  ));
}
