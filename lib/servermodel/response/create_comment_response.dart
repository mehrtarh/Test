import 'package:job/api/error/error_model.dart';
import 'package:job/servermodel/model/comment_model.dart';
import 'package:job/servermodel/model/post_model.dart';
import 'base_respons.dart';

class  CreateCommentResponse extends BaseResponse<CommentModel>{

  CreateCommentResponse.fromJson(Map<String,dynamic>json):
        super.fromJson(json, CommentModel.fromJson(json['data']));


  Map<String, dynamic> toJson()
  {
    List<CommentModel> _result=result;

    return super.toJsonBase(_result.map((e) => e.toJson()).toList());
  }

  CreateCommentResponse.withError(ErrorModel errorModel) : super.withError(errorModel);

}