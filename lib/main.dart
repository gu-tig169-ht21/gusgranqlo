import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'second_view.dart';
import 'todo_list.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => TodoList(),
    child: const MyApp(),
  ));
}

class Todo {
  String syssla;
  bool kryssbox;

  //konstruktor
  Todo({required this.syssla, this.kryssbox = false});

  Map<String, dynamic> toJson() {
    return {'syssla': syssla, 'kryssbox': kryssbox};
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(syssla: json['syssla'], kryssbox: json['kryssbox']);
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override //för att kunna överlagra och göra min egna build funktion
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainView(),
      theme: ThemeData(primarySwatch: Colors.pink),
    );
  }
}

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);
  @override //för att kunna överlagra och göra min egna build funktion
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late String syssla;
  late bool kryssbox;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text('TIG169 TODO'),
          toolbarHeight: 70,
          actions: [
            PopupMenuButton(
                onSelected: (String value) => {
                      Provider.of<TodoList>(context, listen: false)
                          .setFilterBy(value)
                    },
                itemBuilder: (context) => [
                      const PopupMenuItem(child: Text("All"), value: 'all'),
                      const PopupMenuItem(
                        child: Text("Done"),
                        value: 'done',
                      ),
                      const PopupMenuItem(
                        child: Text("Undone"),
                        value: 'undone',
                      )
                    ])
          ]),
      body: Consumer<TodoList>(
        builder: (context, state, child) => _list(
          state.getFilteredList(state.list, state.filterBy),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          tooltip: 'Add',
          child: const Icon(Icons.add),
          backgroundColor: Colors.pink,
          onPressed: () async {
            var newTodo = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SecondView(
                  Todo(syssla: ''),
                ),
              ),
            );
            if (newTodo != null) {
              Provider.of<TodoList>(context, listen: false).addTodo(newTodo);
            }
          }),
    );
  }
}

Widget _radiListan(context, Todo todo) {
  var textDecoration = TextDecoration.none;
  if (todo.kryssbox) {
    textDecoration = TextDecoration.lineThrough;
  }
  return ListTile(
    leading: Checkbox(
      value: todo.kryssbox,
      activeColor: Colors.blue,
      onChanged: (bool? kryssbox) {
        Provider.of<TodoList>(context, listen: false).changeState(todo);
      },
    ),
    title: Text(
      todo.syssla,
      style: TextStyle(fontSize: 20, decoration: textDecoration),
    ),
    trailing: IconButton(
        icon: const Icon(Icons.highlight_remove),
        onPressed: () {
          var state = Provider.of<TodoList>(context, listen: false);
          state.removeTodo(todo);
        }),
  );
}

Widget _list(sysslor) {
  return ListView.builder(
      itemBuilder: (context, index) => _radiListan(context, sysslor[index]),
      itemCount: sysslor.length);
}
