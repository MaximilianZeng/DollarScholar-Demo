import 'package:flutter/material.dart';
import 'package:DollarScholar/theme.dart';
import 'dart:convert';

import 'package:DollarScholar/Util/course_firebase_methods.dart';

import 'package:provider/provider.dart';

import 'package:DollarScholar/Model/user.dart' as user;

/* -- Onboarding Page 1: Select study goal -- */
class OnboardingFirstScreen extends StatefulWidget {

    OnboardingFirstScreen({Key key, @required this.advancePage}) : super(key: key);

    final Function(int) advancePage;

    @override
    _OnboardingFirstScreenState createState() => _OnboardingFirstScreenState();
}

class _OnboardingFirstScreenState extends State<OnboardingFirstScreen> {

    Map _goal;

    List<String> _goalList;

    @override
    void initState() {
        super.initState();
        _goalList = <String>[];
        _goal = Provider.of<user.User>(context, listen: false).goal;
    }

    Widget _buildGoalBubble(String text, int index, BuildContext context) {

        return GestureDetector(
            onTap: () {
                setState(() {
                    _goal["index"] = index;
                    _goal["text"] = text;
                    Provider.of<user.User>(context, listen: false).setGoal = _goal;
                    this.widget.advancePage(0);
                });
            },
            child: Container(
                color: (_goal["index"] == index) ? Color(0xFF4356FF) : Colors.transparent,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                            ClipRRect(
                                child: Image.asset("assets/goal${index+1}.png", scale: 7,),
                                borderRadius: BorderRadius.circular(13.0),
                            ),
                            SizedBox(height: 15,),
                            Text(text,
                                style: Theme.of(context).textTheme.bodyText1
                            )
                        ],
                    ),
                ),
            ),
        );
    }

    @override
    Widget build(BuildContext context) {
        return FutureBuilder(
            future: getGoal(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                    _goalList = snapshot.data;
                    return Scaffold(
                        backgroundColor: Theme.of(context).primaryColor,
                        body: Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Column (
                            children: [
                                Text(
                                    "What is your primary goal?",
                                    style: Theme.of(context).textTheme.headline1
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                                Expanded(
                                    child: ListView.builder(
                                    padding: EdgeInsets.only(top: 0.0),
                                    physics: BouncingScrollPhysics(),
                                    itemCount: _goalList.length,
                                    itemBuilder: (context, index) {
                                        return _buildGoalBubble(
                                            _goalList[index], 
                                            index, 
                                            context
                                        );
                                    },
                                ),)
                            ],
                            ),
                        )
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