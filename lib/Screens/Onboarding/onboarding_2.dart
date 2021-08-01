import 'package:flutter/material.dart';
import 'package:DollarScholar/theme.dart';
import 'package:provider/provider.dart';
import 'package:DollarScholar/Model/course.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:DollarScholar/Util/course_firebase_methods.dart';

// Model
import 'package:DollarScholar/Model/user.dart' as user;


/* -- Onboarding Page 2: Select interested courses -- */
class OnboardingSecondScreen extends StatefulWidget {
    OnboardingSecondScreen({Key key}) : super(key: key);

    @override
    _OnboardingSecondScreenState createState() => _OnboardingSecondScreenState();
}

class _OnboardingSecondScreenState extends State<OnboardingSecondScreen> {
    var _selected = <String>[]; // list of selected interests
    // var _selectedID = <String>[];

    List<Course> _courseList = <Course>[];
    Map _goal;

    @override
    void initState() { 
        super.initState();
        _goal = Provider.of<user.User>(context, listen: false).goal;
        print("selected goal is: $_goal");
    }

    Widget _buildCourseBubble(String item, String id) {
        final checked = _selected.contains(id);

        return Padding(
            padding: EdgeInsets.all(15),
            child: RaisedButton(
                elevation: 0,
                shape: RoundedRectangleBorder (
                borderRadius: BorderRadius.circular(7.0),
                side: BorderSide(
                    color: checked
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).primaryColor),
                ),
                child: Container(
                    width: MediaQuery.of(context).size.width*0.5,
                    child: Text(
                        item ?? " ",
                        style: TextStyle(color: checked ? Colors.white : Colors.black, fontSize: 15),
                    ),
                ),
                onPressed: () {
                    setState(() {
                        if (checked) {
                            _selected.remove(id);
                            // _selectedID.remove(id);
                        } else {
                            _selected.add(id);
                            // _selectedID.add(id);
                        }
                    });
                },
                color: checked ? Color(0xFF4356FF) : Colors.white,
            ),
        );
    }

    Widget _buildCourseTiles(List<Course> _courses) {
        List<Widget> _imageWidget = [];
        _courses.forEach((element) { 
            _imageWidget.add(
                _buildCourseBubble(element.name, element.id)
            );
        });

        return GridView.count(
            primary: false,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            crossAxisCount: 2,
            children: _imageWidget
        );
    }

    @override
    Widget build(BuildContext context) {
        _selected = Provider.of<user.User>(context, listen: true).coursesList;
        // print(_selected);
        // _selectedID = Provider.of<user.User>(context, listen: false).coursesIDs;

        return FutureBuilder(
        future: getCoursesFromGoal(_goal["text"]),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
                _courseList = snapshot.data;
                return Padding(
                    padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                            Text(
                                "Which course are you interested in?",
                                style: Theme.of(context).textTheme.headline1
                            ),
                            Expanded(
                                child: _buildCourseTiles(_courseList),
                            ),
                        ]
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