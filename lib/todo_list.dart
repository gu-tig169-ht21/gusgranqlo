import 'package:flutter/material.dart';
import 'internet_connection.dart';
import 'main.dart';

class TodoList extends ChangeNotifier {
  TodoList() {
    getTodo();
  }

  List<Todo> _list = [];
  var _filterBy = 'all';

  String get filterBy => _filterBy;

  List<Todo> get list {
    return _list;
  }

  Future getTodo() async {
    _list = await InternetConnection.getList();
    notifyListeners();
  }

  //funktion som adderar en Todo
  void postTodo(String id) async {
    _list = await InternetConnection.postTodo(id);
    notifyListeners();
  }

  // funktion som raderar en Todo
  void deleteTodo(Todo todo) async {
    _list = await InternetConnection.deleteTodo(todo);
    notifyListeners();
  }

  //funktion som ändrar state på kryssboxen
  void changeState(Todo todo) async {
    todo.kryssbox = !todo.kryssbox;
    _list = await InternetConnection.putTodo(todo);
    notifyListeners();
  }

  void setFilterBy(String filterBy) {
    _filterBy = filterBy;
    notifyListeners();
  }

  List<Todo> getFilteredList(_list, _filterBy) {
    if (_filterBy == 'all') {
      return list;
    } else if (_filterBy == 'done') {
      return list.where((item) => item.kryssbox == true).toList();
    } else if (_filterBy == 'undone') {
      return list.where((item) => item.kryssbox == false).toList();
    } else {
      return list;
    }
  }
}
