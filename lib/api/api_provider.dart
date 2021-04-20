import 'dart:async';

import 'package:job/api/api.dart';
import 'package:job/servermodel/response/create_comment_response.dart';
import 'package:job/servermodel/response/create_post_response.dart';
import 'package:job/servermodel/response/post_list_response.dart';
abstract class ApiProviderAbstract {


  Future<PostListResponse> getPosts(int pageSize, int pageNumber,
      {String title});

  Future<CreatePostResponse> createPost() ;

  Future<CreateCommentResponse> createComment(
      String postId, String user, String body);


}

class ApiProviderI implements ApiProviderAbstract{

  final MyApi _jobApi;

  ApiProviderI () : _jobApi = MyApiImplementation();


  @override
  Future<CreateCommentResponse> createComment(String postId, String user, String body) async{
    try{
      return _jobApi.createComment(postId, user, body);
    } catch (e) {
      var completer = new Completer<CreateCommentResponse>();
      completer.complete(CreateCommentResponse.withError(e));
      return completer.future;
    }
  }

  @override
  Future<CreatePostResponse> createPost() async{
    try{
      return _jobApi.createPost();
    } catch (e) {
      var completer = new Completer<CreatePostResponse>();
      completer.complete(CreatePostResponse.withError(e));
      return completer.future;
    }
  }

  @override
  Future<PostListResponse> getPosts(int pageSize, int pageNumber, {String title=''}) async{
    try{
      return _jobApi.getPosts(pageSize, pageNumber, title: title);
    } catch (e) {
      var completer = new Completer<PostListResponse>();
      completer.complete(PostListResponse.withError(e));
      return completer.future;
    }
  }

}

