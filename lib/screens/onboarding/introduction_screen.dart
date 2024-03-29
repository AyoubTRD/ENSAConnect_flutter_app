import 'package:ensa/blocs/user_bloc.dart';
import 'package:ensa/screens/core/main_screen.dart';
import 'package:ensa/screens/core/splash_screen.dart';
import 'package:ensa/widgets/onboarding/intro_page_widget.dart';
import 'package:ensa/widgets/core/page_view_indicator_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IntroductionScreen extends StatefulWidget {
  static const routeName = '/welcome';
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  final PageController _pageController = PageController(initialPage: 0);

  bool redirected = false;

  double _opacity = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: userBloc.isReady,
        builder: (context, snapshot) {
          final isReady = snapshot.data ?? false;
          if (!isReady) return SplashScreen();
          Future.delayed(Duration(milliseconds: 1), () {
            setState(() {
              _opacity = 1;
            });
          });
          if (userBloc.isAuthenticated.value && !redirected) {
            redirected = true;
            Future.delayed(Duration(milliseconds: 1), () {
              print('Redirecting to main screen');
              Navigator.of(context).popAndPushNamed(MainScreen.routeName);
            });
          }
          return Container(
            color: Colors.white,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 300),
              opacity: _opacity,
              curve: Curves.easeInOutCubic,
              child: Scaffold(
                body: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 30.0,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed('/signup');
                              },
                              child: Text('Skip'),
                            ),
                          ),
                        ),
                        Expanded(
                          child: PageView(
                            physics: BouncingScrollPhysics(),
                            controller: _pageController,
                            children: [
                              IntroPage(),
                              IntroPage(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IntroPage(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.only(top: 30.0),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushNamed('/signup');
                                        },
                                        child: Text('Create account'),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        PageViewIndicator(
                          controller: _pageController,
                          itemCount: 3,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
