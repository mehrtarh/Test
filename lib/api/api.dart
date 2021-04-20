import 'package:dio/dio.dart';
import 'package:job/servermodel/response/create_comment_response.dart';
import 'package:job/servermodel/response/create_post_response.dart';
import 'package:job/servermodel/response/post_list_response.dart';

import 'api_config.dart';
import 'endpoint.dart';
import 'error/error_handling.dart';

abstract class MyApi {
  Future<PostListResponse> getPosts(int pageSize, int pageNumber,
      {String title});

  Future<CreatePostResponse> createPost() ;

  Future<CreateCommentResponse> createComment(
      String postId, String user, String body) ;
}

class MyApiImplementation implements MyApi {
  Dio _dio;

  MyApiImplementation() {
    _dio = ApiConfig.createServer();
  }

  @override
  Future<CreateCommentResponse> createComment(
      String postId, String user, String body) async {
    try {
      Response response = await _dio.post(EndPoint.getCommentUrl(postId),
          data: {'user': user, 'body': body});
      return CreateCommentResponse.fromJson({'data':response.data});
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return CreateCommentResponse.withError(ErrorHandling.getErrorModel(error));
    }
  }

  @override
  Future<CreatePostResponse> createPost() async {
    try {
      Response response = await _dio.post(EndPoint.post);
      return CreatePostResponse.fromJson({'data':response.data});
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return CreatePostResponse.withError(ErrorHandling.getErrorModel(error));
    }
  }

  @override
  Future<PostListResponse> getPosts(int pageSize, int pageNumber,
      {String title}) async {
    try {
      Response response = await _dio.get(
        EndPoint.post,
        queryParameters: {
          "page": pageNumber,
          "limit": pageSize,
          "title": title
        },
      );
      return PostListResponse.fromJson(
          {'data':response.data}
          );
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return PostListResponse.withError(ErrorHandling.getErrorModel(error));
    }
  }
}
