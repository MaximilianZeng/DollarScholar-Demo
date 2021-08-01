import 'package:flutter/material.dart';
import 'package:DollarScholar/theme.dart';

import 'package:DollarScholar/Model/course.dart';

/* -- True/False Question Screen -- */
class TrueFalseQuestionScreen extends StatefulWidget {
    TrueFalseQuestionScreen(this._question);

    final Question _question;

    @override
    _TrueFalseQuestionScreenState createState() => _TrueFalseQuestionScreenState();
}

class _TrueFalseQuestionScreenState extends State<TrueFalseQuestionScreen> {
    int _selection = -1; // 0 - "True", 1 - "False"

    @override
    Widget build(BuildContext context) {

        Future<void> _showAnswerDialog(bool ifCorrect, int correctIndex) async {
            String correctAnswer = "True";
            if (correctIndex == 1) {
                correctAnswer = "False";
            }
            showDialog(
                context: context,
                builder: (BuildContext context) {
                    return AlertDialog(
                    title: ifCorrect ? 
                        Text("You are correct!", 
                            style: TextStyle(fontSize: 25, color: Theme.of(context).primaryColor),)
                        : Text("Not really...", 
                            style: TextStyle(fontSize: 25, color: Color(0xFFD67171)),),
                    content: SingleChildScrollView(
                        child: ListBody(
                        children: [
                            ifCorrect ? 
                            Container()
                            : Text("The correct answer is ${correctAnswer}.",
                                    style: TextStyle(color: Colors.black87, fontSize: 18),),
                            SizedBox(height: 10),
                            Text(widget._question.explanation,
                                style: TextStyle(color: Colors.black87, fontSize: 15),),
                        ],
                        ),
                    ),
                    actions: <Widget>[
                        ElevatedButton(
                            onPressed: () {
                                Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(30.0),
                                )
                            ),
                            child: Text('Close', style: TextStyle(fontSize: 20))
                        ),
                    ],
                    );
                });
        }

        return Scaffold(
            body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    // Question
                    Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                            color: Color(0xFF4356FF),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                                BoxShadow(
                                    color: Color(0xFFEEEEEE),
                                    blurRadius: 5.0, // soften the shadow
                                    spreadRadius: 5.0, //extend the shadow
                                )
                            ],
                        ),
                        padding: const EdgeInsets.all(25),
                        margin: const EdgeInsets.only(bottom: 50),
                        child: Text(widget._question.question,
                            style: TextStyle(
                                color: Colors.white,
                                height: 1.4,
                                fontSize: 24,
                                fontWeight: FontWeight.w600
                            )),
                    ),

                    // Answer options
                    Row(
                        children: [
                            // True Option
                            Expanded(
                                flex: 10,
                                child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Colors.black,
                                            width: 1,
                                            style: BorderStyle.solid
                                        ), 
                                    borderRadius: BorderRadius.circular(50)),
                                    color: _selection == 0 ? Colors.black : Colors.white,
                                    onPressed: () {
                                        setState(() {
                                            _selection = 0;
                                            _showAnswerDialog(_selection == widget._question.correctIndex, widget._question.correctIndex);
                                        });
                                        // Check answer
                                    },
                                    child: Text('TRUE', style: TextStyle(
                                        color: _selection == 0 ? Colors.white : Colors.black,
                                        fontSize: 17, 
                                        fontWeight: FontWeight.w400),
                                    ),
                                    height: 50,
                                ),
                            ),

                            Spacer(flex: 1,),

                            // False Option
                            Expanded(
                                flex: 10,
                                child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Colors.black,
                                            width: 1,
                                            style: BorderStyle.solid
                                        ), 
                                    borderRadius: BorderRadius.circular(50)),
                                    color: _selection == 1 ? Colors.black : Colors.white,
                                    onPressed: () {
                                        setState(() {
                                            _selection = 1;
                                            _showAnswerDialog(_selection == widget._question.correctIndex, widget._question.correctIndex);
                                        });
                                        // Check answer
                                    },
                                    child: Text('FALSE', style: TextStyle(
                                        color: _selection == 1 ? Colors.white : Colors.black,
                                        fontSize: 17, 
                                        fontWeight: FontWeight.w400),),
                                    height: 50,
                                ),
                            ),
                        ],
                    )
                ],
            ),
            ),
        );
    }
}