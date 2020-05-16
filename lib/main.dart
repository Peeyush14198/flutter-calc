import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "";
  String result = "0";
  String expression = "";
  double equationFontSize = 28.0;
  double resultFontSize = 38.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "";
        result = "0";
        equationFontSize = 28.0;
        resultFontSize = 38.0;
      } else if (buttonText == "⌫") {
        equationFontSize = 28.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 28.0;
        resultFontSize = 38.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 28.0;
        resultFontSize = 38.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
          color: buttonColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                  color: Colors.white24, width: 1, style: BorderStyle.solid)),
          padding: EdgeInsets.all(16.0),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          // Expanded(
          //     child: Container(
          //   alignment: Alignment.centerRight,
          //   padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          //   child: Text(
          //     equation,
          //     style: TextStyle(fontSize: equationFontSize, color: Colors.white),
          //   ),
          // )),
          Container(
            height: 100,
            child: ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: Text(
                    equation,
                    style: TextStyle(
                        fontSize: equationFontSize, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              maxLines: 1,
              style: TextStyle(fontSize: resultFontSize, color: Colors.white),
            ),
          ),

          Expanded(child: Container()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                "MC",
                style: TextStyle(color: Colors.grey[600], fontSize: 15.0),
              ),
               Text(
                "MR",
                style: TextStyle(color: Colors.grey[600], fontSize: 15.0),
              ),
               Text(
                "M+",
                style: TextStyle(color: Colors.grey[600], fontSize: 15.0),
              ),
               Text(
                "M-",
                style: TextStyle(color: Colors.grey[600], fontSize: 15.0),
              ),
               Text(
                "MS",
                style: TextStyle(color: Colors.grey[600], fontSize: 15.0),
              ),
               Text(
                "M+",
                style: TextStyle(color: Colors.grey[600], fontSize: 15.0),
              )
            ],
          ),
          Container(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                        decoration: BoxDecoration(color: Colors.black),
                        children: [
                          buildButton("%", 1, Colors.grey[800]),
                          buildButton("CE", 1, Colors.grey[800]),
                          buildButton("C", 1, Colors.grey[800]),
                        ]),
                    TableRow(
                        decoration: BoxDecoration(color: Colors.black),
                        children: [
                          buildButton("1/x", 1, Colors.grey[800]),
                          buildButton("x^2", 1, Colors.grey[800]),
                          buildButton("√x", 1, Colors.grey[800]),
                        ]),
                    TableRow(children: [
                      buildButton("7", 1, Colors.black54),
                      buildButton("8", 1, Colors.black54),
                      buildButton("9", 1, Colors.black54),
                    ]),
                    TableRow(children: [
                      buildButton("4", 1, Colors.black54),
                      buildButton("5", 1, Colors.black54),
                      buildButton("6", 1, Colors.black54),
                    ]),
                    TableRow(children: [
                      buildButton("1", 1, Colors.black54),
                      buildButton("2", 1, Colors.black54),
                      buildButton("3", 1, Colors.black54),
                    ]),
                    TableRow(children: [
                      buildButton(".", 1, Colors.black54),
                      buildButton("0", 1, Colors.black54),
                      buildButton("00", 1, Colors.black54),
                    ]),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("⌫", 1, Colors.grey[800]),
                    ]),
                    TableRow(children: [
                      buildButton("÷", 1, Colors.grey[800]),
                    ]),
                    TableRow(children: [
                      buildButton("×", 1, Colors.grey[800]),
                    ]),
                    TableRow(children: [
                      buildButton("-", 1, Colors.grey[800]),
                    ]),
                    TableRow(children: [
                      buildButton("+", 1, Colors.grey[800]),
                    ]),
                    TableRow(children: [
                      buildButton("=", 1, Colors.blueAccent),
                    ]),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// void main() => runApp(new MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       title: 'Calculator',
//       debugShowCheckedModeBanner: false,
//       theme: new ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: new CalculatorPage(),
//     );
//   }
// }

// class CalculatorPage extends StatefulWidget {
//   @override
//   _CalculatorPageState createState() => new _CalculatorPageState();
// }

// class _CalculatorPageState extends State<CalculatorPage> {
//   TextEditingController textEditingController = new TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         color: Colors.black,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: new Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: 60.0,
//                 decoration: BoxDecoration(
//                     color: Colors.black,
//                     border: Border.all(color: Colors.white),
//                     borderRadius: BorderRadius.circular(5.0)),
//               ),
//               Container(
//                 height: 10.0,
//               ),
//               new Container(
//                 width: double.infinity,
//                 height: 50.0,
//                 child: new Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Flexible(flex: 1, child: CustomButton("C")),
//                     Flexible(flex: 1, child: CustomButton("+/-")),
//                     Flexible(flex: 1, child: CustomButton("%")),
//                     Flexible(flex: 1, child: CustomButton("\u00F7"))
//                   ],
//                 ),
//               ),
//               new Container(
//                 width: double.infinity,
//                 height: 50.0,
//                 child: new Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Flexible(flex: 1, child: CustomButton("7")),
//                     Flexible(flex: 1, child: CustomButton("8")),
//                     Flexible(flex: 1, child: CustomButton("9")),
//                     Flexible(flex: 1, child: CustomButton("X"))
//                   ],
//                 ),
//               ),
//               Container(
//                 width: double.infinity,
//                 height: 50.0,
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Flexible(flex: 1, child: CustomButton("4")),
//                     Flexible(flex: 1, child: CustomButton("5")),
//                     Flexible(flex: 1, child: CustomButton("6")),
//                     Flexible(flex: 1, child: CustomButton("-"))
//                   ],
//                 ),
//               ),
//               Container(
//                 width: double.infinity,
//                 height: 50.0,
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Flexible(flex: 1, child: CustomButton("1")),
//                     Flexible(flex: 1, child: CustomButton("2")),
//                     Flexible(flex: 1, child: CustomButton("3")),
//                     Flexible(flex: 1, child: CustomButton("+"))
//                   ],
//                 ),
//               ),
//               Container(
//                 height: 50.0,
//                 width: double.infinity,
//                 child: new Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Flexible(flex: 2, child: CustomButton("0")),
//                     Flexible(flex: 1, child: CustomButton(".")),
//                     Flexible(flex: 1, child: CustomButton("=")),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CustomButton extends StatelessWidget {
//   String text;

//   CustomButton(this.text);

//   @override
//   Widget build(BuildContext context) {
//     return new Container(
//       margin: new EdgeInsets.all(6.0),
//       height: double.infinity,
//       width: double.infinity,
//       alignment: Alignment.center,
//       decoration: new BoxDecoration(
//           borderRadius: new BorderRadius.all(new Radius.circular(16.0)),
//           color: Colors.white24),
//       child: new Text(
//         text,
//         style: new TextStyle(color: Colors.white, fontSize: 26.0),
//       ),
//     );
//   }
// }
