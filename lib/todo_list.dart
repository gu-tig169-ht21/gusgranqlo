import 'package:flutter/material.dart';
import 'main.dart';

class TodoList extends ChangeNotifier {
  final List<Todo> _list = [];

  //TodoList(this._filterBy);

  var _filterBy = 'all';

  String get filterBy => _filterBy;

  List<Todo> get list {
    return _list;
  }

  //funktion som adderar en Todo
  void addTodo(Todo syssla) {
    _list.add(syssla);
    notifyListeners();
  }

  // funktion som raderar en Todo
  void removeTodo(Todo todo) {
    _list.remove(todo);
    notifyListeners();
  }

  //funktion som ändrar state på kryssboxen
  void changeState(Todo todo) {
    todo.kryssbox = !todo.kryssbox;
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
