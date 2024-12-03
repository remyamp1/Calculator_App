import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  var UserQuestion = '';
  var UserAnswer = '';

  List<String> button = [
    "C",
    "DEL",
    "%",
    "/",
    "9",
    "8",
    "7",
    "x",
    "6",
    "5",
    "4",
    "-",
    "3",
    "2",
    "1",
    "+",
    "0",
    ".",
    "ANS",
    "="
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 242, 248),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 160,
            ),
            Text(UserQuestion,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(UserAnswer,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 7,
                        crossAxisSpacing: 7,
                        crossAxisCount: 4),
                    itemCount: button.length,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              UserAnswer = '';
                              UserQuestion = '';
                            });
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:
                                    const Color.fromARGB(255, 214, 70, 240)),
                            child: Center(
                              child: Text(button[index],style: TextStyle(fontSize: 25),),
                            ),
                          ),
                        );
                      } else if (index == 1) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              UserQuestion = UserQuestion.substring(
                                  0, UserQuestion.length - 1);
                            });
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(255, 214, 70, 240)),
                            child: Center(child: Text(button[index],style: TextStyle(fontSize: 25),)),
                          ),
                        );
                      } else if (index == button.length - 1) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              equalPressed();
                            });
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:const Color.fromARGB(255, 214, 70, 240)),
                            child: Center(
                                child: Text(
                              button[index],
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            )),
                          ),
                        );
                      } else {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              UserQuestion += button[index];
                            });
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                            
                                borderRadius: BorderRadius.circular(10),
                                color: isOperator(button[index])
                                    ? const Color.fromARGB(255, 214, 70, 240)
                                    : Colors.white,),
                            child: Center(
                                child: Text(
                              button[index],style: TextStyle(fontSize: 25,
                              color:isOperator(button[index])
                              ? Colors.white
                              : const Color.fromARGB(255, 1, 25, 44)),
                              ),
                              
                            )
                            ),
                          
                        );
                      }
                      
                    }))
          ],
        ),
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'x' || x == '+' || x == '-' || x == '=') {
      return true;
    } else {
      return false;
    }
  }

  void equalPressed() {
    String finalQuestion = UserQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    UserAnswer = eval.toString();
  }
}