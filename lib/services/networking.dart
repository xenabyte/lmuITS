import 'package:http/http.dart' as http;
import  'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);
  final String url;

  Future getData () async {
    http.Response channelData = await http.get(url);
    if(channelData.statusCode == 200){
      String channels = channelData.body;
      return jsonDecode(channels);
    }else {
      print(channelData.statusCode);
    }
  }
}