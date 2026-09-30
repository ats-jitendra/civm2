import 'package:CIVM/piedmont/models/album.dart';
import 'package:http/http.dart' as http;

class APIServices {
  Future<Album?> getAlbums() async {
    var client = http.Client();
    var uri = Uri.parse('https://jsonplaceholder.typicode.com/albums/1');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return albumFromJson(json);
    }
  }
}
