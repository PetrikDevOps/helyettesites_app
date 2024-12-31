import 'package:flutter/material.dart';

class WScrollableAutoscrollingText extends StatefulWidget {
  final String text; 
  final Border border;
  final double speed;
  final double delay;

  const WScrollableAutoscrollingText({
    super.key, 
    required this.text,
    this.border = const Border(),
    this.speed = 50,
    this.delay = 2000,
  });

  @override
  State<WScrollableAutoscrollingText> createState() => _WScrollableAutoscrollingTextState();
}

class _WScrollableAutoscrollingTextState extends State<WScrollableAutoscrollingText> {
  late ScrollController _scrollController;

  

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(
      initialScrollOffset: 0,
      keepScrollOffset: true,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  void _scroll(BuildContext context) async{
    while (context.mounted) {
      await Future.delayed(Duration(milliseconds: widget.delay.toInt()));
      await _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: (widget.speed * _scrollController.position.maxScrollExtent).toInt()),
        curve: Curves.linear,
      );
      await Future.delayed(Duration(milliseconds: 1000));
      _scrollController.jumpTo(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    _scroll(context);

    return Container(
      decoration: BoxDecoration(
        border: widget.border, 
      ),
      child: SizedBox(
        width: width * 0.95,
        height: height * 0.8,
        child: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(width * 0.01, 0, width*0.01, 0),
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: Center(child: Text(widget.text, style: TextStyle(color: Color(0xDFFFFFFF), fontSize: width * 0.05))),
            ),
          ),
        ),
      ),
    );
 }
}
