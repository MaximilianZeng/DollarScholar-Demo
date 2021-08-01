import 'package:flutter/material.dart';
import 'package:DollarScholar/theme.dart';

/* -- Module Complete Page -- */
class ModuleCompleteScreen extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: Padding(
            padding: const EdgeInsets.fromLTRB(30, 60, 30, 0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Text(
                    "Credit Card 101",
                    style: Theme.of(context).textTheme.headline1
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                    Padding(padding: const EdgeInsets.all(16.0)),

                    Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                        children: [
                        Text(
                            'Module Complete!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                height: 1.4,
                                fontSize: 26,
                                fontWeight: FontWeight.w800
                            ),
                        ),
                        SizedBox(height: 20,),
                        Text(
                            '+ 45 DS Pt',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w600
                            )
                        )
                        ],
                    )

                    ),

                    Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                        children: [
                        Image.asset("assets/icon.png", scale: 1,),
                        Text(
                            '@lsie0208',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFF6A6A6A),
                                fontSize: 15,
                                height: 1.8,
                                fontWeight: FontWeight.w600
                            )
                        ),
                        Text(
                            '8722',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 29,
                                height: 1.2,
                                fontWeight: FontWeight.w800
                            )
                        ),
                        SizedBox(height: 20,),
                        Text(
                            'You have earned 137 DS pt today!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFF6A6A6A),
                                fontSize: 19,
                                // height: 2.5,
                                fontWeight: FontWeight.w400
                            )
                        )
                        ],
                    )
                    ),

                    Padding(
                    padding: const EdgeInsets.all(60.0),
                    ),

                    Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                        children: [
                        SizedBox(
                            width: 300,
                            height: 50,
                            child: ElevatedButton(
                                onPressed: () {
                                    // Go to the catalog page
                                    Navigator.popUntil(context, ModalRoute.withName('/catalog'));
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Theme.of(context).primaryColor,
                                    shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(30.0),
                                    )
                                ),
                                child: Text('Next Module', 
                                style: TextStyle(fontSize: 22))
                            ),
                        ),
                        TextButton(
                            onPressed: () {
                                // Perform some action
                                // Go to the home/courses page
                                    Navigator.popUntil(context, ModalRoute.withName('/courses'));
                            },
                            style: TextButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                            ),
                            child: const Text('Back to courses',
                            style: TextStyle(fontSize: 18)),
                        )
                        ],
                    )
                    ),

                ],
                )
                ],
            )
            )
        );
    }
}