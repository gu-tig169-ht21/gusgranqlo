import 'package:flutter/material.dart';
import 'main.dart';

class SecondView extends StatefulWidget {
  final Todo kryssbox;

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
  final _formKey = GlobalKey<FormState>();

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
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 24,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, top: 40),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'What are you going to do?',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter some text';
                    }
                    return null;
                  },
                  controller: _controller),
            ),
            _addRow(context),
          ],
        ),
      ),
    );
  }

  Widget _addRow(context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 20),
      child: RaisedButton.icon(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.pop(context, Todo(syssla: _controller.text));
            }
          },
          icon: const Icon(Icons.add),
          label: const Text('ADD'),
          color: Colors.pink.shade100),
    );
  }
}
