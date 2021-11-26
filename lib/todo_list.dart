import 'package:flutter/material.dart';
import 'package:my_first_app/internet_connection.dart';
import 'main.dart';

class TodoList extends ChangeNotifier {
  List<Todo> _list = [];

  var _filterBy = 'all';
  String get filterBy => _filterBy;

  List<Todo> get list {
    return _list;
  }

  void init() async {
    _list = await InternetConnection.getTodo();
    notifyListeners();
  }

  //BEHÖVER JAG HA DETTA?????
  //   Future List<Todo> getTodos (){
  //   return _list;
  // }
  // Future List<Todo> getTodo() async {
  //   _list = await InternetConnection.getTodo();
  //   notifyListeners();
  //   return _list;
  // }

  //funktion som adderar en Todo
  void addTodo(Todo syssla) async {
    _list = await InternetConnection.getTodo();
    // _list.add(syssla);
    notifyListeners();
  }

  // funktion som raderar en Todo
  void removeTodo(Todo todo) async {
    _list = await InternetConnection.deleteTodo(todo);
    notifyListeners();
  }

//DESSA TVÅ FUNKTIONERNA SKULLE JAG VILJA HA HJÄLP MED
  //funktion som ändrar state på kryssboxen
  void changeState(Todo todo) async {
    todo.kryssbox = !todo.kryssbox;
    _list = await InternetConnection.putTodo(todo);
    notifyListeners();
  }

//ÄVEN DENNA FUNKTIONEN
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
