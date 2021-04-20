import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job/pages/home/home_viewmodel.dart';

import 'package:job/presentation/colors_value.dart';
import 'package:job/presentation/texts_value.dart';
import 'package:job/servermodel/model/comment_model.dart';
import 'package:job/servermodel/model/post_model.dart';
import 'package:job/widget/loading_widget.dart';
import 'package:job/widget/no_data_widget.dart';
import 'package:job/widget/custom_elevation.dart';
import 'package:provider/provider.dart';

import 'comment_viewmodel.dart';

class CommentView extends StatelessWidget {
  final postId;
  final _formKey = GlobalKey<FormState>();

  CommentView({Key key, this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();

    return ChangeNotifierProvider<CommentViewModel>(
        create: (context) {
          CommentViewModel viewModel = CommentViewModel();
          viewModel.initialise();
          viewModel.setPostId(postId);
          return viewModel;
        },
        child:Form(
        key: _formKey,
        child:  AlertDialog(
          title: Text(TextsValue.createNewComment),
          content: TextFormField(
            validator: (value) {
              if (value.trim().isEmpty) {
                return TextsValue.enterText;
              }
              return null;
            },
            controller: _controller,
          ),
          actions: <Widget>[
            Consumer<CommentViewModel>(builder: (context, model, child) {
              if (model.close) {
                Navigator.pop(context, model.comment);
              }

              return
    ElevatedButton(
    child: model.loading?Container(
      padding: EdgeInsets.only(top: 4,bottom: 4),
      child: CircularProgressIndicator(backgroundColor: ColorsValue.addCommentProgress,),
      width: 32,
      height: 32,
    ):Text(TextsValue.addComment),
    onPressed: () {
    if (_formKey.currentState.validate()) {
      model.addComment(_controller.text);
    }
                },
              );
            })
          ],
        )));
  }
}
