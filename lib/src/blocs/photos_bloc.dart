import '../models/photos.dart';
import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class PhotosBloc {
  final _repository = Respository();
  final _photosFetcher = PublishSubject<List<PhotoModel>>();

  Stream<List<PhotoModel>> get allPhotos => _photosFetcher.stream;

  fetchAllPhotos(int albumId) async {
    if (_isDisposed) {
      this.allPhotos;
      //return;
    }

    List<PhotoModel> photoModel = await _repository.fetchAllPhotos(albumId);

    _photosFetcher.sink.add(photoModel);
  }

  bool _isDisposed = false;
  dispose() {
    _photosFetcher.close();
    _isDisposed = true;
  }
}

final bloc = PhotosBloc();
