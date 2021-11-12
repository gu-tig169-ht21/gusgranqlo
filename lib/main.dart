import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp());
}

class Todo {
  final String syssla;
  final bool kryssbox;
//
  Todo(this.syssla, this.kryssbox);
}

class MyApp extends StatelessWidget {
  @override //för att kunna överlagra och göra min egna build funktion
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainView(),
      theme: ThemeData(primarySwatch: Colors.pink),
      // home: SecondView(),
    );
  }
}
//----------KLASSEN FÖR FÖRSTA SIDAN -----------------

class MainView extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('TIG169 TODO'),
          toolbarHeight: 70,
        ),
        body: _list(),
        floatingActionButton: FloatingActionButton(
            tooltip: 'Add',
            child: Icon(Icons.add),
            backgroundColor: Colors.pink,
            onPressed: () {
              //KOLLA PÅ DETTA
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SecondView()));
            }));
  }
}

Widget _list() {
  List<Todo> sysslor = [
    Todo('Diska', true),
    Todo('Städa', true),
    Todo('Laga mat', false),
  ];

  return ListView.builder(
      itemBuilder: (context, index) => _RadiListan(sysslor[index]),
      itemCount: 3);
  // return ListView(children: sysslor.map((text) => _item(text)).toList(),);
}

// Widget _item(text) {
//   return Row();
// return Padding(
//   padding: const EdgeInsets.all(20.0),
//   child: Text(text,
//       style: TextStyle(fontSize: 20)), //SKALL JAG HA EN CHECKBOX HÄR??
// Checkbox(
//   value: false,
//   onChanged: (val) {},)

Widget _RadiListan(Todo todo) {
  var textDecoration = TextDecoration.none;
  if (todo.kryssbox) {
    textDecoration = TextDecoration.lineThrough;
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Checkbox(
        value: todo.kryssbox,
        onChanged: (val) {},
      ),
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
        onPressed: (null),
      )
    ],
  );
}

// Widget _appBar2() {
//  return Container(
//     //  _menu(),
//    children: [
//       icon: Icon(Icons.more_vert)
//       leading: const IconButton(
//          icon: Icon(Icons.more_vert), //TRE PRICKAR SOM SKALL VARA MED I MAINVIEW
//          tooltip: 'Navigation menu',
//          onPressed: null, ),
//      height: 70,
//      decoration:  BoxDecoration(color: Colors.pink.shade200),
//      child: Center( child: Text('TIG169 TODO',style: TextStyle(color: Colors.black, fontSize: 22),),

//      )

//  );
//    ;
//  ;

// }

Widget _menu() {
  return Row(
    children: [
      Icon(Icons.person),
    ],
  );
}

// Widget _checkboxRow(_list()) {  //sätta in en lista här som argument
// return Row(
//   children: [
//     Checkbox(
//       value: false,
//       onChanged: (val) { },
//     ),
//     Text('Laga mat och diska'),
//     Text('$sysslor'),
//   ],
// );
//   }

//----------KLASSEN FÖR ANDRA SIDAN-------------------

class SecondView extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('TIG169 TODO'),
        toolbarHeight: 70,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 24,
          ),
          //  _appBar(),
          Container(
            margin: EdgeInsets.only(left: 20, top: 40),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'What are you going to do?',
                border: OutlineInputBorder(),
              ),
            ),
          ), //STÖRRE BOKSTÄVER
          _addRow(),
        ],
      )),
    );
  }

//appbar längst upp på sidan
  Widget _appBar() {
    return Container(
        height: 70,
        decoration: BoxDecoration(color: Colors.pink.shade200),
        child: Center(
          child: Text(
            'TIG169 TODO',
            style: TextStyle(color: Colors.black, fontSize: 22),
          ),
        ));
  }

  Widget _addRow() {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 20),
      child: Text('+ ADD'),
    );
  }
}
