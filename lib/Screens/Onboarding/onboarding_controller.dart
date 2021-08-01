import 'package:flutter/material.dart';
import 'package:DollarScholar/Screens/Onboarding/onboarding_1.dart';
import 'package:DollarScholar/Screens/Onboarding/onboarding_2.dart';
import 'package:DollarScholar/Screens/Onboarding/onboarding_3.dart';

import 'package:provider/provider.dart';

import 'package:DollarScholar/Model/user.dart' as user;


class CreateAccountPage extends StatefulWidget {
    CreateAccountPage({Key key}) : super(key: key);

    @override
    _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {

    PageController _pageController;
    int _slideIndex;


    Widget _buildPageIndicator(int currentIndex){
        return Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            height: currentIndex == _slideIndex ? 13.0 : 10.0,
            width: currentIndex == _slideIndex ? 13.0 : 10.0,
            decoration: BoxDecoration(
                color: currentIndex > _slideIndex ? Colors.black26 : Colors.black87,
                borderRadius: BorderRadius.circular(12),
            ),
        );
    }

    @override
    void initState() {
        super.initState();
        _slideIndex = 0;
        _pageController = new PageController();
    }

    @override
    void dispose() {
        _pageController.dispose();
        super.dispose();
    }

    _gotoPage(int _slideIndex) {
        _pageController.animateToPage(_slideIndex, duration: Duration(milliseconds: 300), curve: Curves.linear);
    }

    _advancePage(int _slideIndex) {
        if (_slideIndex == 0) {
            Provider.of<user.User>(context, listen: false).clearCourse();
        }
        _gotoPage(_slideIndex+1);
    }

    _restartProcess(){
        Provider.of<user.User>(context, listen: false).clearSelection();
        _gotoPage(0);
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                /* Top Bar */
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                    // left arrow
                    _slideIndex != 0 ? IconButton(
                        icon: Icon(Icons.arrow_back_ios_rounded),
                        onPressed: () {
                            _slideIndex -= 1;
                            _pageController.animateToPage(_slideIndex, duration: Duration(milliseconds: 400), curve: Curves.linear);
                        },
                        iconSize: 27.0,
                        color: Colors.white,
                    ) : Container(height: 48, width: 48,),
                    // Dots
                    Container(
                        child: Row(
                        children: [
                            for (int i = 0; i < 3 ; i++) 
                                _buildPageIndicator(i)
                        ],),
                    ),
                    // Right Arrow
                    (_slideIndex != 2 && _slideIndex != 0) 
                        ? IconButton(
                            icon: Icon(Icons.arrow_forward_ios_rounded),
                            onPressed: () {
                                _slideIndex += 1;
                                _pageController.animateToPage(_slideIndex, duration: Duration(milliseconds: 400), curve: Curves.linear);
                            },
                            iconSize: 27.0,
                            color: Colors.white,
                        ) : Container(height: 48, width: 48,),
                ],),

                /* Page Content */
                Expanded(
                    flex: 18,
                    child: Container(
                        child: PageView(
                            physics: NeverScrollableScrollPhysics(),
                            controller: _pageController,
                            onPageChanged: (index) {
                                setState(() => _slideIndex = index);
                            },
                            children: <Widget>[
                                OnboardingFirstScreen(
                                    advancePage: (int val) {
                                        _advancePage(val);
                                    }
                                ),

                                OnboardingSecondScreen(),

                                OnboardingThirdScreen(
                                    restartProcess: _restartProcess
                                ),
                            ],
                        ),
                    ),
                ),
            ],
            ),
        ),
        );
    }
}