import 'package:DollarScholar/Util/course_firebase_methods.dart';
import 'package:flutter/material.dart';
import 'package:DollarScholar/theme.dart';

import 'package:DollarScholar/Model/course.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/* -- Module Catalog Page -- */
class ModuleCatalogScreen extends StatelessWidget {

    Widget _buildModule(Course _course, Module _module, BuildContext context) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                        _module.name,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                        ),
                    ),
                ),

                // Module Catalog
                Expanded(
                child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                        color: Colors.black54,
                    ),
                    padding: EdgeInsets.only(top: 15.0),
                    // controller: _scrollController1,
                    physics: BouncingScrollPhysics(),
                    itemCount: _module.contentList.length+1,
                    itemBuilder: (context, index) {
                        if (index == _module.contentList.length) {
                            return GestureDetector(
                                onTap: () {
                                    Navigator.pushNamed(
                                        context,
                                        '/quiz',
                                        arguments: {"course": _course, "module":_module}
                                    );
                                },
                                child: Padding(
                                    padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                                    child: Text("Module Quiz",
                                        style: Theme.of(context).textTheme.bodyText1
                                    ),
                                ),
                            );
                        }
                        return GestureDetector(
                            onTap: () {
                                Navigator.pushNamed(
                                    context,
                                    '/content',
                                    arguments: {"course": _course, "module":_module, "initialIndex": index}
                                );
                            },
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                                child: Text(_module.contentList.reversed.toList()[index],
                                    style: Theme.of(context).textTheme.bodyText1
                                ),
                            ),
                        );
                    },
                ),
                )
            ],
        );
    }

    @override
    Widget build(BuildContext context) {
        Course _course = ModalRoute.of(context).settings.arguments;
        List<Module> _moduleList = <Module>[];

        return FutureBuilder(
        future: getModuleFromCourse(_course.id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
                _moduleList = snapshot.data;

                return Scaffold(
                backgroundColor: Theme.of(context).backgroundColor,
                body: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 60, 30, 0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                                TextButton(
                                    onPressed: () {
                                        Navigator.of(context).pop();
                                    },
                                    child: Text(
                                        'Back',
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
                                        _course.name,
                                        overflow: TextOverflow.visible,
                                        style: Theme.of(context).textTheme.headline2
                                    ),
                                ),
                                Container(width: MediaQuery.of(context).size.width * 0.15,)
                            ],),

                            SizedBox(height: MediaQuery.of(context).size.height * 0.01,),

                            Expanded(
                                child: ListView.builder(
                                    padding: EdgeInsets.only(top: 0.0),
                                    physics: BouncingScrollPhysics(),
                                    itemCount: _moduleList.length,
                                    itemBuilder: (context, index) {
                                        return ConstrainedBox(
                                        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.35, minHeight: 56.0),
                                        child: GestureDetector(
                                            onTap: ()=> Navigator.pushNamed(
                                                context,
                                                '/content',
                                                arguments: {"course": _course, "module":_moduleList[index]}
                                            ),
                                            child: _buildModule(_course, _moduleList[index], context),
                                        ),
                                        );
                                    },
                                ),
                            )
                    ],),
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

/**
 * single screen testing. Global state management not available
 */
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
        title: 'Module Catalog screen demo',
        theme: appTheme,
        home: ModuleCatalogScreen(),
        );
    }
}