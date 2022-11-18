import 'package:ensa/widgets/core/app_bar_widget.dart';
import 'package:flutter/material.dart';

class FormScreen extends StatelessWidget {
  const FormScreen(
      {Key? key,
      required this.form,
      required this.title,
      required this.subtitle,
      required this.bottomText})
      : super(key: key);

  final Widget form;
  final String title;
  final String subtitle;
  final Widget bottomText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MyAppBar(),
      body: SizedBox(
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).viewInsets.bottom,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(
                top: 100.0, bottom: 30.0, left: 20.0, right: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      subtitle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    form,
                  ],
                ),
                bottomText,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
