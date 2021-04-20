import 'package:job/base/base_viewmodel.dart';
import 'package:job/servermodel/model/comment_model.dart';
import 'package:job/servermodel/model/post_model.dart';
import 'package:job/servermodel/response/post_list_response.dart';
import 'package:job/utils/utils.dart';


class LoginViewModel extends JobBaseViewModel{


  @override
  void initialise() {

  }


  void addNameAndLastName(String name,String lastName)
  {
    getPref().setFirstName(name);
    getPref().setLastName(lastName);
  }




}
