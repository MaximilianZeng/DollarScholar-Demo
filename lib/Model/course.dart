import 'package:flutter/foundation.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Content {
    String title;
    String description;
    String image_path;

    Content(this.title, this.description, this.image_path);
}

class Question {
    String question;
    bool ifMultiChoice;
    List<String> options = [];
    int correctIndex;
    String explanation;

    Question(this.question, this.ifMultiChoice, this.correctIndex, this.explanation);
}

class Module {
    String id;
    String name;
    int point;

    List<String> contentList = [];

    List<Question> questionList = [];

    // Constructor
    Module(this.id, this.name, this.point);
}

class Course {
    String id;
    String name;
    String description;
    List<Module> moduleList = [
        // new Module("Module 1: Asset Classes", 20),
        // new Module("Module 2: Asset Classes", 20),
    ];

    Course(this.id, this.name, this.description);
}

// Course testCourse = new Course();

void getQuestions(inst, id, moduleId) async {
    final snapShot = inst
        .collection('courses')
        .doc(id)
        .collection('module')
        .doc(moduleId)
        .collection("questions")
        .get()
        .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) {
            print("QUESTIONS");
            print(doc.data());
        });
    });
    return snapShot;
}

void getContents(inst, id, moduleId) async {
  final snapShot = inst
      .collection('courses')
      .doc(id)
      .collection('module')
      .doc(moduleId)
      .collection("contents")
      .get()
      .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
        print("CONTENT");
        print(doc.data());
        });
    });
    return snapShot;
}

void getModule(inst, String id) async {
    final snapShot = inst
        .collection('courses')
        .doc(id)
        .collection('module')
        .get()
        .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
        print("MODULE");
        print(doc.data());
        getContents(inst, id, doc.id);
        getQuestions(inst, id, doc.id);
        });
    });
    return snapShot;
}

void getCourse() async {
    FirebaseFirestore inst = FirebaseFirestore.instance;

    final snapShot =
        inst.collection('courses').get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
            print("COURSE");
            print(doc.data());
            getModule(inst, doc.id);
        });
    });

    return snapShot;
}
