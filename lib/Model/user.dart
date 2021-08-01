import 'package:flutter/foundation.dart';

class User extends ChangeNotifier {
    // Properties
    Map goal = {
        "index": -1, 
        "text": ""
    };

    List<String> coursesList = <String>[]; // store id of selected courses

    // Setters
    set setGoal(Map goal) {
        this.goal = goal;
        notifyListeners();
    }

    set setCoursesList(List<String> interestsList) {
        this.coursesList = interestsList;
        notifyListeners();
    }

    // Other Methods
    clearCourse() {
        coursesList.clear();
        notifyListeners();
    }

    clearSelection() {
        goal.clear();
        coursesList.clear();
        notifyListeners();
    }
}