import 'package:flutter/material.dart';
import 'package:DollarScholar/theme.dart';

import 'package:DollarScholar/Model/course.dart';

/* -- Multiple Choice Quiz Screen -- */
class MultipleChoiceScreen extends StatefulWidget {
    MultipleChoiceScreen(this._question);

    final Question _question;

    @override
    _MultipleChoiceScreenState createState() => _MultipleChoiceScreenState();
}

class _MultipleChoiceScreenState extends State<MultipleChoiceScreen> {
    int _selection = -1;

    Future<void> _showAnswerDialog(bool ifCorrect, int correctIndex) async {
        String correctAnswer = "A";
            if (correctIndex == 1) {
                correctAnswer = "B";
            } else if(correctIndex == 2) {
                correctAnswer = "C";
            } else if(correctIndex == 3) {
                correctAnswer = "D";
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
                            // Navigator.of(context).pushNamed('/true_false');
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

    Widget _buildAnswers() {
        List<Widget> _imageWidget = [];
        var _options = widget._question.options;
        _options.forEach((element) { 
            var index = _options.indexOf(element);
            _imageWidget.add(
                GestureDetector(
                onTap: () {
                    setState(() {
                        _selection = index;
                        _showAnswerDialog(_selection == widget._question.correctIndex, widget._question.correctIndex);
                    });
                },
                child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: _selection == index ? Color(0xFF4356FF) : Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                            BoxShadow(
                                color: Color(0xAADDDDDD),
                                blurRadius: 10.0, // soften the shadow
                                spreadRadius: 5.0, //extend the shadow
                            )
                        ],
                    ),
                    child: Center(
                        child: Text("${element}", 
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                fontSize: 22.0,
                                color: _selection == index ? Colors.white : Theme.of(context).accentColor,
                            ),
                            textAlign: TextAlign.center,
                        )
                    ),
                    margin: EdgeInsets.only(bottom: 3),
                ),
                )
            );
        });

        return GridView.count(
            primary: false,
            padding: const EdgeInsets.all(10),
            crossAxisSpacing: 25,
            mainAxisSpacing: 25,
            crossAxisCount: 2,
            children: _imageWidget
        );
    }

    @override
    Widget build(BuildContext context) {
        // _selected = Provider.of<SignupUser>(context, listen: false).getInterests ?? <String>{};

        return Scaffold(
            body: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(widget._question.question,
                            style: TextStyle(
                                color: Colors.black,
                                height: 1.4,
                                fontSize: 24,
                                fontWeight: FontWeight.w600
                            )),
                    ),
                    Expanded(
                        child: _buildAnswers(),
                    ),
                ]),
            ),
        );
    }
}