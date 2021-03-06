import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_first_app/main.dart';
import 'package:provider/provider.dart';

class SecondView extends StatefulWidget {
  final Todo kryssbox;

  //konstruktor
  SecondView(this.kryssbox);

  @override
  State<StatefulWidget> createState() {
    return _SecondViewState(kryssbox);
  }
}

class _SecondViewState extends State<SecondView> {
  late String syssla;
  late bool kryssbox;
  late TextEditingController _controller;

  _SecondViewState(Todo thing) {
    this.syssla = thing.syssla;
    this.kryssbox = thing.kryssbox;

    _controller = TextEditingController(text: thing.syssla);

    // _controller.addListener(() {
    //   setState(() {
    //     syssla = _controller.text;
    //   });
    // });
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                controller: _controller),
          ), //STÖRRE BOKSTÄVER
          _addRow(context),
        ],
      )),
    );
  }

  Widget _addRow(context) {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 20),
      // ignore: deprecated_member_use
      child: RaisedButton.icon(
          onPressed: () {
            Navigator.pop(context, Todo(_controller.text, false));
            //här skall de finnas en funktion som sparar
          },
          icon: Icon(Icons.add),
          label: Text('ADD'),
          color: Colors.pink.shade100),
    );
  }
}
