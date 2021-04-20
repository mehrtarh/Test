import 'package:job/base/base_viewmodel.dart';
import 'package:job/servermodel/model/comment_model.dart';
import 'package:job/servermodel/model/post_model.dart';
import 'package:job/servermodel/response/post_list_response.dart';
import 'package:job/utils/utils.dart';


class HomeViewModel extends JobBaseViewModel{

  bool isSearching = false;
  String searchQuery = "";
  String preSearchQuery = "";


  List<PostModel> contents = [];

 final int pageSize=10;
  int pageNumber = 0;
  bool finalPage = false;
  bool loadingContents = false;


  @override
  void initialise() {
    getContents();
  }


  void getContents()
  {
    pageNumber++;
    loadingContents=true;
    notifyListeners();
    getStore().getPosts(pageSize, pageNumber,searchQuery).then(_checkContents);
  }



  PostListResponse _checkContents(PostListResponse postsResponse)
  {
    if(postsResponse.isSuccessFull )
      {
        if(postsResponse.result==null || postsResponse.result.length<pageSize)
          finalPage=true;
        
        if(postsResponse.result!=null && postsResponse.result.length>0)
          contents.addAll(postsResponse.result);


      }else {
      finalPage=true;
      Utils.manageError(postsResponse);
    }

    loadingContents=false;

    notifyListeners();
    
    return postsResponse;

  }

  void updatePostComment(CommentModel commentModel) {

    contents.where((element) => element.id==commentModel.postId).first.comments.add(commentModel);
    notifyListeners();

  }

  void setSearchQuery(String newQuery) {
    if(newQuery!=searchQuery) {
      searchQuery = newQuery;
      _clearDataForSearch();
      getContents();
    }

  }

  void setPreSearchQuery(String newQuery) {
  preSearchQuery=newQuery;

  }

  void setSearchStatus(bool value) {

    isSearching=value;
    notifyListeners();

  }

  void _clearDataForSearch()
  {
    preSearchQuery='';
    contents=[];
    pageNumber = 0;
    finalPage = false;
    loadingContents = false;
  }




}
