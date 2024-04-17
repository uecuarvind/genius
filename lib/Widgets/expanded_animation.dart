import 'package:flutter/material.dart';

class ExpandedAnimation extends StatefulWidget {

  final Widget? child;
  final bool expand;
  ExpandedAnimation({this.expand = false, this.child});

  @override
  _ExpandedAnimationState createState() => _ExpandedAnimationState();
}

class _ExpandedAnimationState extends State<ExpandedAnimation> with SingleTickerProviderStateMixin {
  AnimationController? expandController;
  Animation<double>? animation;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    _runExpandCheck();
  }

  ///Setting up the animation
  void prepareAnimations() {
    expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500)
    );
    animation = CurvedAnimation(
      parent: expandController!,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _runExpandCheck() {
    if(widget.expand) {
      expandController!.forward();
    }
    else {
      expandController!.reverse();
    }
  }

  @override
  void didUpdateWidget(ExpandedAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }

  @override
  void dispose() {
    expandController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        axisAlignment: 1.0,
        sizeFactor: animation!,
        child: widget.child
    );
  }
}
