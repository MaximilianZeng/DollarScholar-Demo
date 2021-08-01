import 'package:flutter/material.dart';
import 'multiple_choice.dart';
import 'true_false_choice.dart';

import 'package:DollarScholar/Model/course.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuizPage extends StatefulWidget {
    @override
    _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
    List<Question> _questionList = <Question>[];
    int slideIndex = 0;
    PageController controller;

    Future<List<Question>> getContents(String course_id, String module_id) async {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('courses')
            .doc(course_id)
            .collection('module')
            .doc(module_id)
            .collection("questions")
            .get();

        List<Question> questionList = <Question>[];
        var questionDictionary = querySnapshot.docs[0].data();
        questionDictionary.values.forEach((element) {
        // print(element["question"].toString());
        bool ifMultiChoice = (element["type"].toString() == "MC");
        int correctIndex = 0;
        if (ifMultiChoice) {
            correctIndex = element["answer"];
        } else {
            if (element["answer"]) {
            correctIndex = 0;
            } else {
            correctIndex = 0;
            }
        }
        String explanation = element['explanation'].toString();
        Question newQuestion = new Question(element["question"].toString(),
            ifMultiChoice, correctIndex, explanation);
        List<String> options = <String>[];
        element["options"].forEach((element) {
            newQuestion.options.add(element.toString());
        });
        questionList.add(newQuestion);
        });

        return questionList;
    }

    @override
    void initState() {
        super.initState();
        controller = new PageController();
    }

    @override
    Widget build(BuildContext context) {
        Map _courseInfo = ModalRoute.of(context).settings.arguments;
        print(slideIndex);

        return FutureBuilder(
        future: getContents(_courseInfo["course"].id, _courseInfo["module"].id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
            _questionList = snapshot.data;
            int questionCount = _questionList.length;
            List<Widget> questionPages =
                List<Widget>.generate(questionCount, (int index) {
                if (_questionList[index].ifMultiChoice) {
                return MultipleChoiceScreen(_questionList[index]);
                } else {
                return TrueFalseQuestionScreen(_questionList[index]);
                }
            });

            return Scaffold(
                body: Padding(
                padding: const EdgeInsets.fromLTRB(10, 60, 10, 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        TextButton(
                            onPressed: () {
                            Navigator.of(context).pop();
                            },
                            child: Text(
                            'Exit',
                            ),
                            style: TextButton.styleFrom(
                                primary: Theme.of(context).primaryColor,
                                textStyle: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                )),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                                _courseInfo["course"].name,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.headline2
                            ),
                        ),
                        TextButton(
                            onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamed('/complete');
                            },
                            child: Text(
                            'Finish',
                            ),
                            style: TextButton.styleFrom(
                                primary: Theme.of(context).primaryColor,
                                textStyle: TextStyle(
                                fontSize: 19,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                )),
                        ),
                        ],
                    ),

                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                    ),

                    Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 0, 20),
                        child: Text(
                        _courseInfo["module"].name,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                        ),
                        ),
                    ),

                    Expanded(
                        flex: 18,
                        child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        // height: MediaQuery.of(context).size.height - 100,
                        child: PageView(
                            // physics: NeverScrollableScrollPhysics(),
                            controller: controller,
                            onPageChanged: (index) {
                                setState(() {
                                slideIndex = index;
                                print(slideIndex);
                                });
                            },
                            children: questionPages),
                        ),
                    ),

                    // Bottom page controller
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                        // left arrow
                        IconButton(
                            icon: Icon(Icons.arrow_back_ios_rounded),
                            onPressed: () {
                            slideIndex -= 1;
                            controller.animateToPage(slideIndex,
                                duration: Duration(milliseconds: 400),
                                curve: Curves.linear);
                            },
                            iconSize: 27.0,
                            color: Colors.black54,
                        ),

                        // Content index indicator
                        Text(
                            "${slideIndex + 1}",
                            style: TextStyle(fontSize: 23, color: Colors.black),
                        ),

                        // Right Arrow
                        IconButton(
                            icon: Icon(Icons.arrow_forward_ios_rounded),
                            onPressed: () {
                            slideIndex += 1;
                            controller.animateToPage(slideIndex,
                                duration: Duration(milliseconds: 400),
                                curve: Curves.linear);
                            },
                            iconSize: 27.0,
                            color: Colors.black54,
                        ),
                        ],
                    ),
                    ],
                ),
                ),
            );
            } else {
            return Center(
                child: CircularProgressIndicator(),
            );
            }
        },
        );
    }
}
