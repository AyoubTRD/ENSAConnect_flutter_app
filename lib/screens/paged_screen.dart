import 'package:ensa/utils/constants.dart';
import 'package:flutter/material.dart';

class PagedScreen extends StatefulWidget {
  const PagedScreen(
      {Key? key,
      required this.children,
      this.appBar,
      required this.pageCount,
      required this.pageNames,
      this.onPageChange})
      : super(key: key);

  final List<Widget> children;
  final PreferredSizeWidget? appBar;
  final void Function(int)? onPageChange;
  final int pageCount;
  final List<String> pageNames;

  @override
  _PagedScreenState createState() => _PagedScreenState();
}

class _PagedScreenState extends State<PagedScreen> {
  final _controller = PageController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    if (_controller.page == null) return;
    setState(() {
      _currentIndex = _controller.page!.round();
    });
    if (widget.onPageChange != null) {
      widget.onPageChange!(_currentIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<bool> isSelected = List.generate(widget.pageCount, (index) => false);
    isSelected[_currentIndex] = true;

    Future<void> _scrollToPage() async {
      _controller.removeListener(_onScroll);
      await _controller.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
      _controller.addListener(_onScroll);
    }

    return Scaffold(
      appBar: widget.appBar,
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: kDefaultPadding),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ToggleButtons(
                  isSelected: isSelected,
                  constraints: BoxConstraints(
                    minWidth:
                        (MediaQuery.of(context).size.width - kDefaultPadding) /
                            widget.pageCount,
                    minHeight: 43.0,
                  ),
                  selectedColor: Colors.white,
                  color: Colors.grey[800],
                  fillColor: Theme.of(context).primaryColor,
                  borderWidth: 0.0,
                  borderRadius: BorderRadius.circular(8.0),
                  onPressed: (int index) {
                    setState(() {
                      _currentIndex = index;
                    });
                    if (widget.onPageChange != null)
                      widget.onPageChange!(index);
                    _scrollToPage();
                  },
                  children: widget.pageNames.map((e) => Text(e)).toList(),
                ),
              ),
            ),
            Expanded(
              child: PageView(
                controller: _controller,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: widget.children,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
