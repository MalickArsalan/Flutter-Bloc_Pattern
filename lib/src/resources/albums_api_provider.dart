import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/albums.dart';

class AlbumsApiProvider {
  Client client = Client();

  Future<List<AlbumModel>> fetchAlbumList() async {
    final response =
        await client.get('https://jsonplaceholder.typicode.com/albums');

    if (response.statusCode == 200) {
      return compute(parseAlbums, response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }
}

List<AlbumModel> parseAlbums(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<AlbumModel>((json) => AlbumModel.fromJson(json)).toList();
}
