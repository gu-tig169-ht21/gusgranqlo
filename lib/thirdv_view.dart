import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

// denna klassen skall ta en lista som argument med de
// sysslorna som skall visas, antigen undone eller done

class ThirdView extends StatefulWidget {
  var list;
  ThirdView(lista) {
    list = lista;
  }
  @override
  State<StatefulWidget> createState() {
    return ThirdViewState();
  }
}

class ThirdViewState extends State<ThirdView> {
  bool isOn = false;

  Widget build(BuildContext context) {
    Color buttonColor = Colors.red;
    if (isOn) {
      buttonColor = Colors.green;
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              child: TextButton(
                child: Text(
                  'Hejsan',
                  style: TextStyle(color: buttonColor),
                ),
                onPressed: () {
                  setState(() {
                    isOn = !isOn;
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
