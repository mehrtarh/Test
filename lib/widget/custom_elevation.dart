import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomElevation extends StatelessWidget {
  final Widget child;
  final double height;

  CustomElevation({@required this.child, @required this.height})
      : assert(child != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: this.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(this.height / 2)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            blurRadius: height / 10,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: this.child,
    );
  }
}