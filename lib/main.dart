import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Calculadora(),
      theme: ThemeData(),
    );
  }
}

class Calculadora extends StatefulWidget {
  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String num1 = '';
  String num2 = '';
  String operation;
  bool isSecondNumber = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Text(
                isSecondNumber ? num2 : num1,
                style: TextStyle(fontSize: 99),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              numButton(1),
              numButton(2),
              numButton(3),
              opButton('+'),
            ],
          ),
          Row(
            children: <Widget>[
              numButton(4),
              numButton(5),
              numButton(6),
              opButton('-'),
            ],
          ),
          Row(
            children: <Widget>[
              numButton(7),
              numButton(8),
              numButton(9),
              opButton('x')
            ],
          ),
          Row(
            children: <Widget>[
              actionButton("C"),
              numButton(0),
              actionButton('='),
              opButton('/'),
            ],
          ),
        ],
      ),
    );
  }

  Expanded numButton(int num) {
    return Expanded(
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xffdddddd),
          ),
        ),
        child: FlatButton(
          color: Colors.white,
          onPressed: () {
            _addNumber(num);
          },
          child: Text(
            "$num",
            style: TextStyle(fontSize: 25),
          ),
        ),
      ),
    );
  }

  Expanded opButton(String op) {
    return Expanded(
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.white,
            ),
          ),
        ),
        child: FlatButton(
          color: Colors.blue,
          onPressed: () {
            _addOperator(op);
          },
          child: Text(
            op,
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
        ),
      ),
    );
  }

  Expanded actionButton(String action) {
    return Expanded(
      child: Container(
        height: 80,
        child: FlatButton(
          color: Color(0xffeeeeee),
          onPressed: action == 'C' ? _clear : _operate,
          child: Text(
            action,
            style: TextStyle(
              fontSize: 25,
            ),
          ),
        ),
      ),
    );
  }

  void _addNumber(int num) {
    setState(() {
      if (isSecondNumber) {
        num2 = num2 + "$num";
      } else {
        num1 = num1 + "$num";
      }
    });
  }

  void _addOperator(String op) {
    setState(() {
      isSecondNumber = true;
      operation = op;
    });
  }

  void _clear() {
    num1 = '';
    num2 = '';
    isSecondNumber = false;
    operation = '';
    setState((){});
  }

  void _operate() {
    int rta = 0;
    int n1 = int.parse('0' + num1);
    int n2 = int.parse('0' + num2);
    switch (operation) {
      case '+':  rta = n1 + n2; break;
      case '-': rta = n1 - n2; break;
      case '*': rta = n1 * n2; break;
      case '/': rta = n1 ~/ n2; break;
    }

    setState(() {
      isSecondNumber = false;
      num1 = '$rta';
      num2 = '';
    });
  }
}
