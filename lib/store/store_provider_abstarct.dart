import 'dart:async';

import 'package:job/api/api_provider.dart';
import 'package:job/pref/pref_provider.dart';
import 'package:job/servermodel/response/create_comment_response.dart';
import 'package:job/servermodel/response/create_post_response.dart';
import 'package:job/servermodel/response/post_list_response.dart';

abstract class StoreProviderAbstract {
  ApiProviderAbstract getApi();

  PrefProviderAbstract getPref();

  Future<PostListResponse> getPosts(int pageSize,int pageNumber,String searchValue,
      {bool loadFromCache = false, bool loadCacheWhenNotData = true});

  Future<CreatePostResponse> createPost();

  Future<CreateCommentResponse> createComment(String postId,String user,String body);

}
