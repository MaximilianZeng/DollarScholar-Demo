import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_methods.dart';
import 'package:DollarScholar/Model/course.dart';

FirebaseFirestoreMethods _firestore = new FirebaseFirestoreMethods();

Future<List<Course>> getCoursesFromGoal(String goal) async {
    QuerySnapshot courseSnapshot = await _firestore.getCollectionSnapshot("courses");

    List<Course> courseList = <Course>[];
    courseSnapshot.docs.forEach((doc) {
        String courseGoal = doc.data()["goal"].toString() ?? "";
        if (courseGoal == goal) {
            courseList.add(new Course(doc.id.toString(), doc["name"].toString(), doc["description"].toString()));
        }
    });
    return courseList;
}

Future<List<String>> getGoal() async {
    QuerySnapshot goalsSnapshot = await _firestore.getCollectionSnapshot("goals");

    dynamic goalListRaw = goalsSnapshot.docs[0].data()["goal"];
    List<String> goalList = <String>[];

    for (var goal in goalListRaw)
        goalList.add(goal);
    return goalList;
}

Future<List<Course>> getSelectedCourses(List<String> courseIDs) async {
    
    QuerySnapshot courseSnapshot = await _firestore.getCollectionSnapshot("courses");

    List<Course> courses = <Course>[];
    courseSnapshot.docs.forEach((doc) {
        if (courseIDs.contains(doc.id.toString())) {
            courses.add(new Course(doc.id.toString(), doc["name"].toString(), doc["description"].toString()));
        }
    });
    return courses;
}

Future<List<Module>> getModuleFromCourse(String course_id) async {

    QuerySnapshot moduleSnapshot = await _firestore.getSubCollectionSnapshot("courses", course_id, "module");

    List<Module> moduleList = <Module>[];
    moduleSnapshot.docs.forEach((doc) {
        Module newModule = new Module(doc.id.toString(), doc["name"].toString(), int.parse(doc["points"].toString()));
        doc["content_names"].forEach((element) {
            newModule.contentList.insert(0, element.toString());
        });
        moduleList.insert(0, newModule);
    });
    return moduleList;
}

Future<List<Content>> getContentFromModule(String course_id, String module_id) async {

    QuerySnapshot contentSnapshot = await _firestore.getSecondarySubCollectionSnapshot("courses", course_id, "module", module_id, "contents");

    List<Content> contentList = <Content>[];
    var contentDictionary = contentSnapshot.docs[0].data();
    contentDictionary.values.forEach((element) {
        Content newContent = new Content(element["title"].toString(), element["desc"].toString(), element["image"].toString());
        contentList.add(newContent);
    });
    return contentList.reversed.toList();
}