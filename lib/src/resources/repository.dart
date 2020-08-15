import 'dart:async';
import 'albums_api_provider.dart';
import '../models/albums.dart';
import '../models/photos.dart';
import 'photos_api_provider.dart';

class Respository {
  final albumsApiProvider = AlbumsApiProvider();

  Future<List<AlbumModel>> fetchAllAlbums() =>
      albumsApiProvider.fetchAlbumList();

  final photosApiProvider = PhotosApiProvider();

  Future<List<PhotoModel>> fetchAllPhotos(int albumId) =>
      photosApiProvider.fetchPhotoList(albumId);
}
