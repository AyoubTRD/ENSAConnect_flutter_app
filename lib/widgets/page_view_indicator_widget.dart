import 'package:flutter/material.dart';

class PageViewIndicator extends StatefulWidget {
  const PageViewIndicator(
      {Key? key, required this.controller, required this.itemCount})
      : super(key: key);

  final PageController controller;
  final int itemCount;

  @override
  _PageViewIndicatorState createState() => _PageViewIndicatorState();
}

class _PageViewIndicatorState extends State<PageViewIndicator> {
  late int _activePage;

  @override
  void initState() {
    super.initState();
    _activePage = widget.controller.initialPage;
    widget.controller.addListener(_onScroll);
  }

  void _onScroll() {
    if (widget.controller.page == null) return;
    setState(() {
      _activePage = widget.controller.page!.round();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.itemCount, (int i) => i)
          .map(
            (e) => AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: e == _activePage ? 28.0 : 9.0,
              height: 9.0,
              margin: const EdgeInsets.symmetric(horizontal: 3.0),
              decoration: BoxDecoration(
                color: e == _activePage
                    ? Theme.of(context).primaryColor
                    : Colors.grey[400],
                borderRadius: BorderRadius.all(
                  const Radius.circular(10.0),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
