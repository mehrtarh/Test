import 'package:job/base/base_viewmodel.dart';
import 'package:job/servermodel/model/comment_model.dart';
import 'package:job/servermodel/model/post_model.dart';
import 'package:job/servermodel/response/create_comment_response.dart';
import 'package:job/servermodel/response/post_list_response.dart';
import 'package:job/utils/utils.dart';


class CommentViewModel extends JobBaseViewModel{


  String postId;
  CommentModel comment;
  bool close=false;
  bool loading=false;


  @override
  void initialise() {
 
  }

  void setPostId(String postId)
  {
this.postId=postId;
  }

 void addComment(String body)
 {
   loading=true;
   notifyListeners();
   String user='';
   getPref().getFirstName().then((value) {
     user=user+value;
   }).whenComplete(() {
     getPref().getLastName().then((value) {
       user=user+' '+value;
     }).whenComplete(() {
       getStore().createComment(postId, user, body).then((CreateCommentResponse response) {
         loading=false;
         if(response.isSuccessFull)
         {
           close=true;
           if(response.result!=null) {
             comment = response.result;
           }

         }else {
         Utils.manageError(response);
         }
         notifyListeners();
         
       });
       
     });
     
   });
   

 }



}
