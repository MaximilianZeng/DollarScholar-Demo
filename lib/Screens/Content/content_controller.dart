import 'package:DollarScholar/Util/course_firebase_methods.dart';
import 'package:flutter/material.dart';
import 'term_explanation.dart';
import 'package:DollarScholar/Model/course.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContentPage extends StatefulWidget {

    @override
    _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
    List<Content> _contentList = <Content>[];
    int slideIndex = 0;
    PageController pageController;

    @override
    void initState() {
        super.initState();
        pageController = new PageController();
    }

    @override
    Widget build(BuildContext context) {
        Map _courseInfo = ModalRoute.of(context).settings.arguments;
        // print(slideIndex);

        return FutureBuilder(
        future: getContentFromModule(_courseInfo["course"].id, _courseInfo["module"].id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
                _contentList = snapshot.data;
                print(_contentList[0].title);
                int contentCount = _contentList.length;
                List<Widget> contentPages = List<Widget>.generate(
                    contentCount, (int index) => TermExplanationScreen(_contentList[index])
                );

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
                                    Navigator.pushNamed(
                                        context,
                                        '/quiz',
                                        arguments: _courseInfo
                                    );
                                },
                                child: Text(
                                    'Quiz',
                                ),
                                style: TextButton.styleFrom(
                                    primary: Theme.of(context).primaryColor,
                                    textStyle: TextStyle(
                                        fontSize: 19,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w500,
                                    )),
                            ),
                        ],),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.02,),

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
                                controller: pageController,
                                onPageChanged: (index) {
                                    setState(() {
                                        slideIndex = index;
                                        print(slideIndex);
                                    });
                                },
                                children: contentPages
                            ),
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
                                pageController.animateToPage(slideIndex, duration: Duration(milliseconds: 400), curve: Curves.linear);
                            },
                            iconSize: 27.0,
                            color: Colors.black54,
                        ),

                        // Content index indicator
                        Text("${slideIndex+1}",
                            style: TextStyle(fontSize: 23, color: Colors.black),),
                            
                        // Right Arrow
                        IconButton(
                            icon: Icon(Icons.arrow_forward_ios_rounded),
                            onPressed: () {
                                slideIndex += 1;
                                pageController.animateToPage(slideIndex, duration: Duration(milliseconds: 400), curve: Curves.linear);
                            },
                            iconSize: 27.0,
                            color: Colors.black54,
                        ),
                    ],),
                ],
                ),
                ),
                );
            }else {
                return Center(
                    child: CircularProgressIndicator(),
                );
            }
            
            },
        );
        
        
        
    }
}