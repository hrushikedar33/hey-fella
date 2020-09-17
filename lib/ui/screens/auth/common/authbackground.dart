import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Authbackground extends StatelessWidget {
  final Widget content;

  const Authbackground({Key key, @required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: Color(0xFF0f1115),
        ),
        SvgPicture.asset('assets/images/dots_rectangle.svg'),
        Positioned(
          child: SvgPicture.asset('assets/images/background_circles.svg'),
          top: 0,
          right: 0,
        ),
        Positioned(
          child: SvgPicture.asset('assets/images/striped_oval.svg'),
          bottom: 0,
          right: 0,
        ),
        content,
      ],
    );
  }
}
