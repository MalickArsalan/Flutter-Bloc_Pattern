import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/photos.dart';

class PhotosApiProvider {
  Client client = Client();

  Future<List<PhotoModel>> fetchPhotoList(int albumId) async {
    final response = await client
        .get('https://jsonplaceholder.typicode.com/photos?albumId=$albumId');

    if (response.statusCode == 200) {
      return compute(parsePhotos, response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }
}

List<PhotoModel> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<PhotoModel>((json) => PhotoModel.fromJson(json)).toList();
}
