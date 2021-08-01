// Libraries
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:DollarScholar/theme.dart';
import 'package:provider/provider.dart';

// Model
import 'package:DollarScholar/Model/user.dart' as user;

// On-boarding Pages
import 'Screens/Onboarding/onboarding_1.dart';
import 'Screens/Onboarding/onboarding_controller.dart';

// Content Pages
import 'Screens/Course/course_info.dart';
import 'Screens/Catalog/catalog.dart';
import 'Screens/Content/content_controller.dart';

// Quiz Pages
import 'Screens/Quiz/quiz_controller.dart';

// Module complete Page
import 'Screens/module_complete.dart';

// Firebase Integration
import 'package:firebase_core/firebase_core.dart';



Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(MyApp());
}

class MyApp extends StatelessWidget {

    final Future<FirebaseApp> _FbApp = Firebase.initializeApp();
    
    @override
    Widget build(BuildContext context) {
        return ChangeNotifierProvider(
            create: (context) => user.User(),
            
            child: MaterialApp (
                debugShowCheckedModeBanner: false,
                title: 'DollarScholar App',
                home: FutureBuilder(
                    future: _FbApp,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasError) {
                            print("Something went wrong");
                            return Text("Something went wrong!");
                        } else if (snapshot.hasData) {
                            return CreateAccountPage();
                        } else {
                            return Center(
                                child: CircularProgressIndicator(),
                            );
                        }
                    },
                ),
                theme: appTheme,
                routes: <String, WidgetBuilder> {
                    '/onboard': (BuildContext context) => new CreateAccountPage(),
                    '/courses': (BuildContext context) => new CourseInfoScreen(),
                    '/catalog': (BuildContext context) => new ModuleCatalogScreen(),
                    '/content': (BuildContext context) => new ContentPage(),
                    '/quiz': (BuildContext context) => new QuizPage(),
                    '/complete': (BuildContext context) => new ModuleCompleteScreen(),
                },
            ),
            
        );
    }
}