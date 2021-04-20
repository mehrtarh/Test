import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job/presentation/colors_value.dart';
import 'package:job/presentation/fonts_value.dart';
import 'package:job/presentation/texts_value.dart';

class LoadingWidget extends StatefulWidget {
  final Color fontColor;
  const LoadingWidget({this.fontColor=Colors.black});
  @override
  _LoadingState createState() => _LoadingState();

}
class _LoadingState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
        width: double.infinity,
        foregroundDecoration: BoxDecoration(color: ColorsValue.loadingForeground),
        child:  Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        child: Column(
          children: [
            Container(
              child: CircularProgressIndicator(),
              width: 42,
              height: 42,
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(TextsValue.loading,style:TextStyle(
                fontSize: 16,
                color: widget.fontColor,
                fontFamily: FontsValue.fontFamily,),),
            )
          ],
        ),
//        width: 120,
        height: 120,
      )
    ]));
  }
}