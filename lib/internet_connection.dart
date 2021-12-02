import 'dart:convert';
import 'package:http/http.dart' as http;
import 'main.dart';

String apikey = 'e6dafde2-dc06-4884-9267-eae13f5c0743';
String url = 'https://todoapp-api-pyq5q.ondigitalocean.app';

class InternetConnection {
  //hämta ner en lista med todos från internet med GET
  static Future<List<Todo>> getList() async {
    http.Response apisvar = await http.get(Uri.parse('$url/todos?key=$apikey'));
    var list = jsonDecode(apisvar.body);

    return list.map<Todo>((obj) {
      return Todo.fromJson(obj);
    }).toList();
  }

//lägga upp en lista med todos till internet med POST
  static Future<List<Todo>> postTodo(String syssla) async {
    Map<String, dynamic> json = {'title': syssla};
    var body = jsonEncode(json);
    var apisvar = await http.post(
      Uri.parse('$url/todos?key=$apikey'),
      body: body,
      headers: <String, String>{'Content-type': 'application/json'},
    );

    body = apisvar.body;
    var list = jsonDecode(body);
    return list.map<Todo>((obj) {
      return Todo.fromJson(obj);
    }).toList();
  }

//ta bort en todos från internet med DELETE
  static Future deleteTodo(Todo todo) async {
    http.Response apisvar =
        await http.delete(Uri.parse('$url/todos/${todo.id}?key=$apikey'));
    var body = jsonDecode(apisvar.body);

    body = apisvar.body;
    var list = jsonDecode(body);
    return list.map<Todo>((obj) {
      return Todo.fromJson(obj);
    }).toList();
  }

//uppdatera listan
  static Future<List<Todo>?> putTodo(Todo todo) async {
    Map<String, dynamic> json = {'title': todo.syssla, 'done': todo.kryssbox};
    var body = jsonEncode(json);
    http.Response apisvar = await http.put(
      Uri.parse('$url/todos/${todo.id}?key=$apikey'),
      body: body,
      headers: <String, String>{'Content-type': 'application/json'},
    );

    body = apisvar.body;
    var list = jsonDecode(body);
    return list.map<Todo>((obj) {
      return Todo.fromJson(obj);
    }).toList();
  }
}
