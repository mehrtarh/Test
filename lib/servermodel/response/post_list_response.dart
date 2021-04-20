import 'package:job/api/error/error_model.dart';
import 'package:job/servermodel/model/post_model.dart';
import 'base_respons.dart';

class  PostListResponse extends BaseResponse<List<PostModel>>{

  PostListResponse.fromJson(Map<String,dynamic>json):
        super.fromJson(json,
          (json['data'] as List)
              .map((contentItem) {
                return PostModel.fromJson(contentItem);
              })
              .toList());


  Map<String, dynamic> toJson()
  {
    List<PostModel> _result=result;

    return super.toJsonBase(_result.map((e) => e.toJson()).toList());
  }


  PostListResponse.withError(ErrorModel errorModel) : super.withError(errorModel);

}