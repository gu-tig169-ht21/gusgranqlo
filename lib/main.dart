import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'second_view.dart';

void main() {
  runApp(
      // här sätter du upp providern
      //och gör att
      //alla barn har tillgång till klassen TodoList
      ChangeNotifierProvider(
    create: (context) => TodoList(),
    child: MyApp(),
  ));
}

class Todo {
  final String syssla;
  final bool kryssbox;
  //konstruktor
  Todo(this.syssla, this.kryssbox);
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);
  @override //för att kunna överlagra och göra min egna build funktion
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainView(),
      //home: ThirdView(),
      theme: ThemeData(primarySwatch: Colors.pink),
    );
  }
}

class TodoList extends ChangeNotifier {
  List<Todo> _list = [];

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
}

class MainView extends StatefulWidget {
  MainView({Key? key}) : super(key: key);
  @override //för att kunna överlagra och göra min egna build funktion
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late String syssla;
  late bool kryssbox;
  late TextEditingController _controller;
  var filterSetting = 'all';

  get allItems => null;

  Widget build(BuildContext context) {
    List<Todo> list = [];

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text('TIG169 TODO'),
          toolbarHeight: 70,
          actions: [
            PopupMenuButton(
                itemBuilder: (context) => [
                      PopupMenuItem(
                          child: const Text("Done"),
                          value: 1,
                          onTap: () {
                            getFilteredList(list, "Done");
                          }),
                      PopupMenuItem(
                          child: const Text("All"), value: 2, onTap: () {}),
                      PopupMenuItem(
                        child: const Text("Undone"),
                        value: 3,
                        onTap: () {
                          getFilteredList(list, 'Undone');
                        },
                      )
                    ])
          ]),
      body: Consumer<TodoList>(
        //Consumer som uppdateras när de ska lägas till et objekt i listan
        builder: (context, state, child) => _list(
          getFilteredList(state.list, filterSetting),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          tooltip: 'Add',
          child: Icon(Icons.add),
          backgroundColor: Colors.pink,
          onPressed: () async {
            var newTodo = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SecondView(
                  Todo('', false),
                ),
              ),
            );
            if (newTodo != null) {
              //inte är null så skall detta göras
              Provider.of<TodoList>(context, listen: false).addTodo(newTodo);
            }
          }),
    );
  }
}

List getFilteredList(allItems, settings) {
  if (settings == "All") return allItems;
  if (settings == "Done") {
    return [
      Todo('Diska', true),
      Todo('Programmera', true),
      Todo('Ringa Karolina', true),
    ];
  }
  if (settings == "Undone") {
    return [
      Todo('Städa', false),
      Todo('Laga mat', false),
      Todo('Gå en runda', false),
      Todo('Mata hunden', false),
      Todo('Gå ut med soporna', false)
    ];
  }
  return allItems;
}

Widget _list(sysslor) {
  return ListView.builder(
      itemBuilder: (context, index) => _RadiListan(context, sysslor[index]),
      itemCount: sysslor.length);
}

Widget _RadiListan(context, Todo todo) {
  var textDecoration = TextDecoration.none;
  if (todo.kryssbox) {
    textDecoration = TextDecoration.lineThrough;
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Checkbox(
          value: todo.kryssbox,
          onChanged: (Todo) {
            var state = Provider.of<TodoList>(context, listen: false);

            // state.kryssbox => setState(() = kryssbox!),
            // setState(() {
            //   todo.kryssbox[] = newTodo;
            // },
            // notifyListeners();
          }),
      Expanded(
        child: Text(
          todo.syssla,
          style: TextStyle(
            fontSize: 20,
            decoration: textDecoration,
          ),
        ),
      ),
      IconButton(
        icon: Icon(Icons.highlight_remove),
        onPressed: () {
          var state = Provider.of<TodoList>(context, listen: false);
          state.removeTodo(todo);
        },
      ),
    ],
  );
}
