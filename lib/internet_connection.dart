import 'dart:convert';
import 'package:http/http.dart' as http;
import 'main.dart';

String apikey = 'e6dafde2-dc06-4884-9267-eae13f5c0743';
String url = 'https://todoapp-api-pyq5q.ondigitalocean.app';

class InternetConnection {
  //hämta ner en lista med todos från internet med GET
  static Future getTodo() async {
    var apisvar = await http.get(Uri.parse('$url/todos?key=$apikey'));
    //print(apisvar);
    var json = jsonDecode(apisvar.body);

    if (apisvar.statusCode == 200) {
      return json.map((obj) => Todo.fromJson(obj)).toList();
    } else {
      return Todo.fromJson(jsonDecode(apisvar.body));
    }
  }

//lägga upp en lista med todos till internet med POST
  static Future postTodo(Todo todo) async {
    var json = todo.toJson();
    var body = jsonEncode(json);
    var apisvar = await http.post(
      Uri.parse('$url/todos?key=$apikey'),
      body: body,
      headers: <String, String>{'Content-type': 'application/json'},
    );
    return apisvar;
  }

//ta bort en todos från internet
  static Future deleteTodo(Todo todo) async {
    var apisvar = await http.delete(Uri.parse('$url /todos/:id?key=$apikey'));
    var json = jsonDecode(apisvar.body);

    return apisvar;
  }

//uppdatera en todos som ligger på internet med PUT
  static Future putTodo(Todo todo) async {
    var json = todo.toJson();
    var body = jsonEncode(json);
    var apisvar = await http.put(
      Uri.parse('$url/todos/:id?key=$apikey'),
      body: body,
      headers: <String, String>{'Content-type': 'application/json'},
    );
    return apisvar;
  }
}
