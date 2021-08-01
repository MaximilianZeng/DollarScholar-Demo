import 'package:flutter/material.dart';
import 'package:DollarScholar/theme.dart';
import 'package:flutter/cupertino.dart';

/* -- Onboarding Page 3: Sign up selection confirmation -- */
class OnboardingThirdScreen extends StatefulWidget {
    OnboardingThirdScreen({Key key, @required this.restartProcess}) : super(key: key);

    final Function restartProcess;

    @override
    _OnboardingThirdScreenState createState() => _OnboardingThirdScreenState();
}

class _OnboardingThirdScreenState extends State<OnboardingThirdScreen> {

    @override
    Widget build(BuildContext context) {

        return Padding(
        padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
        child: Align(
            alignment: Alignment.topCenter,
            child: Card(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: 
                        Text(
                            'You are all set up!',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline1
                        ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: 
                        Text(
                            'You have successfully created your profile. Click "Start" to onboard your DollarScholar journey',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyText1
                        ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: 
                        Text(
                            'After completion, you will recieve',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyText1
                        ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: 
                        Row(mainAxisAlignment: MainAxisAlignment.center ,children: [
                            Image.asset("assets/badge.png", scale: 1,),
                            Text(' + ',style: Theme.of(context).textTheme.bodyText1),
                            Image.asset("assets/coupon.png", scale: 1,),
                            Text(' + ',style: Theme.of(context).textTheme.bodyText1),
                            Text('1628 DS Points',style: Theme.of(context).textTheme.bodyText2),
                        ],),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                            width: 300,
                            height: 50,
                            child: ElevatedButton(
                                onPressed: () {
                                    Navigator.of(context).pushNamedAndRemoveUntil(
                                        '/courses', (Route<dynamic> route) => false);
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Theme.of(context).primaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(30.0),
                                    )
                                ),
                                child: Text('Start', style: TextStyle(fontSize: 20))
                            ),
                        ),
                    ),
                    TextButton(
                        onPressed: () => this.widget.restartProcess(),
                        style: TextButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                        ),
                        child: const Text('Restart Evaluation'),
                    ),
                ],
            ),
            ),
        )
        );
    }
}
