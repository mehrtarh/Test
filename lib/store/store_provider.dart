import 'dart:async';

import 'package:job/api/api_provider.dart';
import 'package:job/api/endpoint.dart';
import 'package:job/api/error/error_model.dart';
import 'package:job/api/error/error_type.dart';
import 'package:job/app/app_model.dart';
import 'package:job/main.dart';
import 'package:job/pref/pref_provider.dart';
import 'package:job/servermodel/response/create_comment_response.dart';
import 'package:job/servermodel/response/create_post_response.dart';
import 'package:job/servermodel/response/post_list_response.dart';
import 'package:job/store/store_provider_abstarct.dart';

class StoreProvider extends StoreProviderAbstract {
  StoreProvider();

  ApiProviderAbstract getApi() {
    return getIt<AppModel>().apiProvider;
  }

  PrefProviderAbstract getPref() {
    return getIt<AppModel>().prefProvider;
  }

  @override
  Future<PostListResponse> getPosts(int pageSize, int pageNumber,String searchValue,
      {bool loadFromCache = false, bool loadCacheWhenNotData = true}) async {
    try {
      bool shouldLoadCache = false;
      PostListResponse result;

      if (loadFromCache) {
        result = await _getPostListCache();
      }
      if (result == null) {
        result = await getApi()
            .getPosts(pageSize, pageNumber,title: searchValue)
            .then((PostListResponse contents) {
          if (contents.isSuccessFull&&contents.result != null && contents.result.length > 0) {
            if(pageNumber==1)
            getPref()
                .writeModelInJson(contents, EndPoint.post, Duration(days: 7));
          } else {
            ErrorModel errorModel = contents.error;
            if (errorModel != null &&
                (errorModel.type == ErrorType.Internet_Connection ||
                    errorModel.type == ErrorType.Timeout)) {
              shouldLoadCache = true;
            }
          }
          return contents;
        });

        if (shouldLoadCache && loadCacheWhenNotData) {
          if(pageNumber==1) {
            PostListResponse cacheResult = await _getPostListCache();
            if (cacheResult != null) result = cacheResult;
          }
        }
      }
      var completer = new Completer<PostListResponse>();
      completer.complete(result);
      return completer.future;
    } catch (e) {
      var completer = new Completer<PostListResponse>();
      completer.complete(PostListResponse.withError(
          ErrorModel(e.toString(), ErrorType.Exception)));
      return completer.future;
    }
  }

  Future<PostListResponse> _getPostListCache() async {
    return await getPref()
        .getModelString(EndPoint.post, true)
        .then((Map<String, dynamic> postJson) {
      if (postJson != null) {
        return PostListResponse.fromJson(postJson);
      } else {
        return null;
      }
    });
  }

  @override
  Future<CreateCommentResponse> createComment(String postId,String user,String body) async {
    return getApi().createComment(postId, user, body);
  }

  @override
  Future<CreatePostResponse> createPost() {
    return getApi().createPost();
  }
}
