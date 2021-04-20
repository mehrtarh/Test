import 'package:job/api/error/error_model.dart';
import 'package:job/servermodel/model/post_model.dart';
import 'base_respons.dart';

class  CreatePostResponse extends BaseResponse<PostModel>{

  CreatePostResponse.fromJson(Map<String,dynamic>json):
        super.fromJson(json, PostModel.fromJson(json.containsKey('data')?json.containsKey('data'):json));


  Map<String, dynamic> toJson()
  {
    List<PostModel> _result=result;

    return super.toJsonBase(_result.map((e) => e.toJson()).toList());
  }

  CreatePostResponse.withError(ErrorModel errorModel) : super.withError(errorModel);

}