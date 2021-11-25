import 'dart:convert';
import 'dart:html';
import 'package:http/http.dart' as http;
//import './InternetFetcher.dart';


const apiKey = 'e6dafde2-dc06-4884-9267-eae13f5c0743';
const url = 'https://todoapp-api-pyq5q.ondigitalocean.app/';


class InternetConnection {
  final String title;
  final String id;

  InternetConnection(this.id, this.title);

  Future<String> _fetchStuffFromInternet() async {
    http.Response response = await http.get(
      Uri.parse(url)
    );

    void fetchId() async {
    var ip = await 
    };
  

    var svar = response.body;
    var jsonData = response.body;
    var obj = jsonDecode(jsonData);
    return '${obj['ip']} i landet ${[country]}';
  }
}
