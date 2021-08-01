import 'package:flutter/material.dart';
import 'package:DollarScholar/theme.dart';
import 'package:DollarScholar/Model/course.dart';

/* -- Term Explanation Page -- */
class TermExplanationScreen extends StatefulWidget {
    TermExplanationScreen(this._content);

    final Content _content;

    @override
    _TermExplanationScreenState createState() => _TermExplanationScreenState();
}

class _TermExplanationScreenState extends State<TermExplanationScreen> {
    
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                        // Title
                        Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                                widget._content.title,
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w500,
                                ),
                            ),
                        ),

                        Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Image.network(widget._content.image_path),
                        ),

                        Text(widget._content.description, 
                            style: TextStyle(
                                fontWeight: FontWeight.normal, 
                                fontSize: 15, 
                                color: Colors.black87
                            )
                        ),

                        
                ]),
        );
    }
}