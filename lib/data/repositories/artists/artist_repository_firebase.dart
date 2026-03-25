import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../model/artists/artist.dart';
import '../../dtos/artist_dto.dart';
import 'artist_repository.dart';

class ArtistRepositoryFirebase extends ArtistRepository{
  final Uri artistsUri = Uri.https('week-8-practice-c244d-default-rtdb.asia-southeast1.firebasedatabase.app','/artists.json');

  @override
  Future<List<Artist>> fetchArtists() async{
    final http.Response response = await http.get(artistsUri);

    if(response.statusCode == 200){
      Map<String, dynamic> artistJson = json.decode(response.body);
      List<Artist> result = [];

      for(var iterable in artistJson.entries){
        String artistId = iterable.key;
        Map<String, dynamic> values = iterable.value;
        result.add(ArtistDto.fromJson(artistId, values));
      }
      return result;
    }else{
      throw Exception('Failed to load artists');
    }
  }
}