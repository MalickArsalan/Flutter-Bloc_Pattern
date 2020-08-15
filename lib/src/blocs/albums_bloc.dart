import '../models/albums.dart';
import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class AlbumsBloc {
  final _respository = Respository();
  final _albumsFetcher = PublishSubject<List<AlbumModel>>();

  Stream<List<AlbumModel>> get allAlbums => _albumsFetcher.stream;

  fetchAllAlbums() async {
    List<AlbumModel> albumModel = await _respository.fetchAllAlbums();

    _albumsFetcher.sink.add(albumModel);
  }

  dispose() {
    _albumsFetcher.close();
  }
}

final bloc = AlbumsBloc();
