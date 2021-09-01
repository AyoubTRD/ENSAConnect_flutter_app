import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/svg/page1.svg',
            width: 250.0,
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            'Find New Friends From ENSA',
            style: Theme.of(context).textTheme.headline1,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            'Find friends who are in the same ENSA as you and others who share same interests as you.',
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
