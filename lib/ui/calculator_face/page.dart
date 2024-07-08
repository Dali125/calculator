//This is the main page for the calculator

import 'package:calculator_kondwani/ui/calculator_face/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';


//This code here can be generated via flutter snippets extensions
class CalculatorHome extends StatefulWidget {
  const CalculatorHome({super.key});

  @override
  State<CalculatorHome> createState() => _CalculatorHomeState();
}


//The UI definitions will come here
class _CalculatorHomeState extends State<CalculatorHome> {


//the symbols and numbers to be displayed on the calculator
List<String> buttonComponents = [
  'AC', '+/-', '%','/',
  '7','8','9', '*',
  '4','5','6', '-',
  '1','2','3', '+',
  '','0','.', '='

];


//This array stores the mathematical Expression
List<String> mathExpression = [];

double mathAnswer = 0;


//This is where we will calculate the answer
void calculateMath(String input){

ContextModel cm = ContextModel();
  Parser p = Parser();
  Expression exp = p.parse(input);


  double eval = exp.evaluate(EvaluationType.REAL, cm);

  mathAnswer = eval;
  print(mathAnswer);


}

//Adds the tapped value to the list
void addToExpression(String component){

  mathExpression.add(component);

}

Color getButtonColor(String button) {
    if (button == 'AC' || button == '%' || button == '+/-') {
      return lightGray;
    } else if (button == '/' || button == '*' || button == '-' || button == '=' || button == '+') {
      return vividGamboge;
    } else {
      return darkLiver;
    }
  }


  @override
  Widget build(BuildContext context) {

   


    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return  Scaffold(
      
      backgroundColor: eerieBlack,
      body: Column(children: [

        Container(

          width: width,
          height: height / 3,
          
          child: Stack(
            children: [
                   Positioned(
                 top:35,
                right: 10,
                child: 
              Text(mathAnswer.toString(), style: TextStyle(fontSize: 50, color: Colors.white))),

              Positioned(
                bottom: 10,
                right: 10,
                child: 
              Text(mathExpression.join() == '' ? '0' : mathExpression.join(), style: TextStyle(fontSize: 40, color: Colors.white),))
            ],
          ),

        ),
        Container(
          width: width,
          height: height /1.5,
          child: GridView.builder(
            
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4 ,crossAxisSpacing: 4, mainAxisSpacing: 4),
            itemCount: buttonComponents.length,
             itemBuilder: (context, index){
              return GestureDetector(
                onTap: (){

                  if(buttonComponents[index] == "AC"){
                    mathExpression = [];
                    mathAnswer = 0;
                  }else if(buttonComponents[index] == "="){

                  calculateMath(mathExpression.join());
                  }else if(buttonComponents[index] == "+/-"){

                     addToExpression('-');

                  }
                  
                  else{
                    addToExpression(buttonComponents[index]);

                  }
                  setState(() {
                    
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: getButtonColor(buttonComponents[index])
                  ),
                  
                  child: Center(child: Text(buttonComponents[index], style: TextStyle(fontSize: 16, color: Colors.white),)),
                ),
              );
          
          
          }),
        )
      ],),




    );
  }
}