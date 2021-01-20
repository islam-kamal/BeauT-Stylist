import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AnimatedWidgets extends StatefulWidget {
  final Widget item;
  final bool dir;

  const AnimatedWidgets({Key key, this.item, this.dir}) : super(key: key);

  @override
  _AnimatedWidgetsState createState() => _AnimatedWidgetsState();
}

class _AnimatedWidgetsState extends State<AnimatedWidgets> {
  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: 1,
      duration: Duration(seconds: 1),
      child: SlideAnimation(
        horizontalOffset: widget.dir == true ? 50.0 : 0,
        verticalOffset: widget.dir == false ? 50.0 : 0,
        child: FadeInAnimation(
          child: widget.item,
        ),
      ),
    );
  }
}
