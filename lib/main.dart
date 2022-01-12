import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';


void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Calculator",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({Key? key}) : super(key: key);

  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double eFontSize = 38.0;
  double rFontSize = 48.0;
  buttonPressed(String B_Text) {
    setState(() {
      if (B_Text == "C") {
        eFontSize = 38.0;
        rFontSize = 48.0;
        equation = "0";
        result = "0";
      }
      else if (B_Text == "⌫") {
        eFontSize = 38.0;
        rFontSize = 48.0;
        equation = equation.substring(0, equation.length - 1);
        if(equation == ""){
          equation = "0";
        }
      }
      else if (B_Text == "=") {
        eFontSize = 38.0;
        rFontSize = 48.0;
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          result = "Error";
        }
      }

      else {
        if (equation == "0") {
          equation = B_Text;
        }
        else {
          eFontSize = 38.0;
          rFontSize = 48.0;
          equation = equation + B_Text;
        }
      }
    });
  }

  Widget buieldButton(String b_text, double B_height, Color B_color) {
    var S_height = MediaQuery.of(context).size.height;
    var S_width = MediaQuery.of(context).size.width;
    return Container(
      height: S_height * B_height,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.white,
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
        ),
        onPressed: () {
          buttonPressed(b_text);
        },
        child: Text(
          "${b_text}",
          style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.normal,
              color: Colors.white),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: B_color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var S_height = MediaQuery.of(context).size.height;
    var S_width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: eFontSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: rFontSize),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: S_width * .75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buieldButton("C", .1, Colors.redAccent),
                        buieldButton("⌫", .1, Colors.lightBlueAccent),
                        buieldButton("÷", .1, Colors.lightBlue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buieldButton("7", .1, Colors.black26),
                        buieldButton("8", .1, Colors.black26),
                        buieldButton("9", .1, Colors.black26),
                      ],
                    ),
                    TableRow(
                      children: [
                        buieldButton("4", .1, Colors.black26),
                        buieldButton("5", .1, Colors.black26),
                        buieldButton("6", .1, Colors.black26),
                      ],
                    ),
                    TableRow(
                      children: [
                        buieldButton("1", .1, Colors.black26),
                        buieldButton("2", .1, Colors.black26),
                        buieldButton("3", .1, Colors.black26),
                      ],
                    ),
                    TableRow(
                      children: [
                        buieldButton(".", .1, Colors.black26),
                        buieldButton("0", .1, Colors.black26),
                        buieldButton("00", .1, Colors.black26),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: S_width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buieldButton("×", .1, Colors.lightBlue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buieldButton("-", .1, Colors.lightBlue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buieldButton("+", .1, Colors.lightBlueAccent),
                      ],
                    ),
                    TableRow(
                      children: [
                        buieldButton("=", .2, Colors.redAccent),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
