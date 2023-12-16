import 'package:flutter/material.dart';
import 'package:flutter_calculator/buttons.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var userQuestion = '';
  var userAnswer = '';



  final List<String> buttons =
  [
    'C', 'DEL', '%', '/',
    '9', '8', '7', 'X',
    '6', '5', '4', '-',
    '3', '2', '1', '+',
    '0', '.', 'ANS', '=',
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.brown[100],
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const SizedBox(height: 50,),
                Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Text(userQuestion, style: TextStyle(fontSize: 20),)
                ),
                Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(userAnswer, style: TextStyle(fontSize: 20),)
                )
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
            itemCount: buttons.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
            itemBuilder: (BuildContext context, int index) {

              // Clear Button
              if (index == 0) {
                return MyButton(
                  buttonTapped: (){
                    setState(() {
                      userQuestion = '';
                    });
                  },
                  buttonText: buttons[index],
                  color: Colors.green,
                  textColor: Colors.white,
                );

              // Delete Button
              } else if (index == 1) {
                return MyButton(
                  buttonTapped: (){
                    setState(() {
                      userQuestion = userQuestion.substring(0,userQuestion.length-1);
                    });
                  },
                  buttonText: buttons[index],
                  color: Colors.red,
                  textColor: Colors.white,
                );

              // Equal Button
              } else if (index == buttons.length-1) {
                return MyButton(
                  buttonTapped: (){
                    setState(() {
                      equalPressed();
                    });
                  },
                  buttonText: buttons[index],
                  color: Colors.brown,
                  textColor: Colors.white,
                );

              // Rest of the Buttons
              } else {
                return MyButton(
                  buttonTapped: (){
                    setState(() {
                      userQuestion += buttons[index];
                    });
                  },
                  buttonText: buttons[index],
                  color: isOperator(buttons[index])
                      ? Colors.brown
                      : Colors.brown[50],
                  textColor: isOperator(buttons[index])
                      ? Colors.white
                      : Colors.brown,


                );
              }
            }),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x){
    if(x == '%' || x == '/' || x == 'X' || x == '-' || x == '+' || x == '=' ){
      return true;
    }
    return false;
  }

  void equalPressed(){
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('X', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toString();
  }
}
