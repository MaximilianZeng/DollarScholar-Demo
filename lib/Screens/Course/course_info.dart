import 'package:flutter/material.dart';
import 'package:DollarScholar/Model/course.dart';

import 'package:provider/provider.dart';

import 'package:DollarScholar/Util/course_firebase_methods.dart';

// Model
import 'package:DollarScholar/Model/user.dart' as user_model;

/* -- Course Info Page -- */
class CourseInfoScreen extends StatelessWidget {

    List<Course> _courses = <Course>[];
    List<String> _courseIDs = <String>[];

    @override
    Widget build(BuildContext context) {
        _courseIDs = Provider.of<user_model.User>(context, listen: false).coursesList;

        return FutureBuilder(
            future: getSelectedCourses(_courseIDs),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                    _courses = snapshot.data;
                    return Scaffold(
                    body: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 80, 30, 0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                            Text("Courses", style: Theme.of(context).textTheme.headline1),

                            SizedBox(
                                height: MediaQuery.of(context).size.height * 0.04,
                            ),

                            Expanded(
                                child: ListView.builder(
                                padding: EdgeInsets.only(top: 0.0),
                                physics: BouncingScrollPhysics(),
                                itemCount: _courses.length,
                                itemBuilder: (context, index) {
                                    return GestureDetector(
                                    onTap: () => Navigator.pushNamed(
                                        context,
                                        '/catalog',
                                        arguments: _courses[index]
                                    ),
                                    child: Container(
                                        margin: EdgeInsets.only(bottom: 20),
                                        decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.all(Radius.circular(10))
                                        ),
                                        child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                        Image.asset(
                                            "assets/course_cover.png",
                                            scale: 1,
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
                                            child: Text(_courses[index].name,
                                                style: Theme.of(context).textTheme.headline3),
                                        ),
                                        ],
                                    )),
                                    );
                                },
                                ),
                            )
                            ]),
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