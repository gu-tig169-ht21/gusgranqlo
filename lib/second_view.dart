import 'package:flutter/material.dart';

import 'package:my_first_app/main.dart';
//import 'package:provider/provider.dart';

class SecondView extends StatefulWidget {
  final Todo kryssbox;

  //konstruktor
  const SecondView(this.kryssbox, {Key? key}) : super(key: key);

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
    syssla = thing.syssla;
    kryssbox = thing.kryssbox;

    _controller = TextEditingController(text: thing.syssla);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('TIG169 TODO'),
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
            margin: const EdgeInsets.only(left: 20, top: 40),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: TextField(
                decoration: const InputDecoration(
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
      margin: const EdgeInsets.only(left: 20, top: 20),
      child: RaisedButton.icon(
          onPressed: () {
            if (_controller != '') {
              Navigator.pop(context, Todo(syssla: _controller.text));
            } else {}
          },
          icon: const Icon(Icons.add),
          label: const Text('ADD'),
          color: Colors.pink.shade100),
    );
  }
}
