import 'package:flutter/cupertino.dart';
import 'package:job/presentation/fonts_value.dart';
import 'package:job/presentation/texts_value.dart';


class NoDataWidget extends StatefulWidget{
  const NoDataWidget();
  @override
  _NoDataState createState() => _NoDataState();
}
class _NoDataState extends State<NoDataWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(child:  Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(TextsValue.noData,style:TextStyle(fontFamily: FontsValue.fontFamily,),),
            )
          ],
        ),
        width: 150,
        height: 72,
      )
    ]));
  }
}