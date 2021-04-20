import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job/pages/comment/comment_view.dart';
import 'package:job/pages/home/home_viewmodel.dart';

import 'package:job/presentation/colors_value.dart';
import 'package:job/presentation/texts_value.dart';
import 'package:job/servermodel/model/comment_model.dart';
import 'package:job/servermodel/model/post_model.dart';
import 'package:job/widget/loading_widget.dart';
import 'package:job/widget/no_data_widget.dart';
import 'package:job/widget/custom_elevation.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget{

 final TextEditingController _searchQueryController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider<HomeViewModel>(
        create: (context) {
          HomeViewModel viewModel= HomeViewModel();
          viewModel.initialise();
          return viewModel;
        } ,
        child: Scaffold(
          primary: true,
          body: Scaffold(
            appBar: _getAppBar(context),
            body: _getBody(),

            // floatingActionButton: CustomElevation(
            //   height: 65,
            //   child: Container(
            //       height: 65.0,
            //       width: 65.0,
            //       child: FittedBox(
            //         child: FloatingActionButton(
            //           shape: CircleBorder(
            //               side: BorderSide(color: Colors.white, width: 8)),
            //           elevation: 0,
            //           onPressed: () {},
            //           child: Icon(
            //             Icons.add,
            //             color: Colors.white,
            //           ),
            //           // elevation: 5.0,
            //         ),
            //       )),
            // ),
          ),
        ));
  }

  Widget _getAppBar(BuildContext context) {
    return  AppBar(
      title:Consumer<HomeViewModel>(
        builder: (context, model, child) {
      return

      model.isSearching ? _buildSearchField(model) : _buildTitle();}),
          actions: _buildActions(context),);
  }

 List<Widget> _buildActions(BuildContext context) {
  return <Widget>[Consumer<HomeViewModel>(
       builder: (context, model, child) {
          if (model.isSearching) {
     return
       IconButton(
         icon: const Icon(Icons.clear),
         onPressed: () {
           if (_searchQueryController == null ||
               _searchQueryController.text.isEmpty) {
             Navigator.pop(context);
             return;
           }
           _clearSearchQuery(model);
         },
       );
   }

   return
     IconButton(
       icon: const Icon(Icons.search),
       onPressed: (){
         _startSearch(context,model);
       },
     );
   })];
 }

 void _startSearch(BuildContext context,HomeViewModel model) {
   ModalRoute.of(context)
       .addLocalHistoryEntry(LocalHistoryEntry(onRemove: (){
     _stopSearching(model);
   }));

   model.setSearchStatus(true);
 }


 void _stopSearching(HomeViewModel model) {
   _clearSearchQuery(model);
   model.setSearchStatus(false);
 }

 void _clearSearchQuery(HomeViewModel model) {

     _searchQueryController.clear();
     model.setSearchQuery('');

 }

 Widget _buildSearchField(HomeViewModel model) {
   return  TextField(
         controller: _searchQueryController,
         autofocus: true,
         decoration: InputDecoration(
           hintText: TextsValue.search,
           border: InputBorder.none,
           hintStyle: TextStyle(color: ColorsValue.searchHint),
         ),
         style: TextStyle(color: Colors.white, fontSize: 16.0),
         onChanged: (query) => model.setPreSearchQuery(query),
     onEditingComplete: ()=> model.setSearchQuery(model.preSearchQuery),
       );
 }


 Widget _buildTitle()
 {
   return Text( TextsValue.postTitle,style: TextStyle(
       fontWeight: FontWeight.bold,fontSize: 24),);
 }

  Widget _getBody()
  {
    return Consumer<HomeViewModel>(
        builder: (context, model, child) {

       return  Stack(
        children: [
          NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (!model.finalPage &&
                    !model.loadingContents &&
                    scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                  model.getContents();
                }
                return false;
              },
              child:  Container(
                      color: ColorsValue.mainBack,
                      child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                           (model.contents.length > 0
                                ?  ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount:model.contents.length,
                                itemBuilder: (BuildContext context,
                                    int index) {
                                  return _getPostItemItem(context,model.contents[index],model);
                                }): model.loadingContents?Container():NoDataWidget()),

                            model.loadingContents?LoadingWidget():Container()


                          ])) )]);});
  }

  Widget _getPostItemItem(BuildContext context ,PostModel model,HomeViewModel homeViewModel)
  {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      height: 40.0,
                      width: 40.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: new NetworkImage(
                                  TextsValue.sampleUserImage))),
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      model.title??'No Title',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),

              ]),
        ),
        AspectRatio(
          aspectRatio: 1.5,
          child: Image.network(
            TextsValue.sampleImage,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(Icons.remove_red_eye_outlined),
                  SizedBox(width: 16.0),
                  Text(model.views.toString()??'0'),
                ],
              ),
            ],
          ),
        ),
  Padding(
  padding: EdgeInsets.only(right: 16,left:24,bottom: 16),
    child: _getCommentList(model.comments??[])),

        Padding(
            padding: EdgeInsets.only(right: 16,left:24,bottom: 16),
            child: GestureDetector(
              onTap: (){

                _showDialog(context,model,homeViewModel);

              },
              child: Text(TextsValue.addComment,style:
            TextStyle(color: ColorsValue.addComment,fontWeight: FontWeight.bold),),)),
      ],
    );
  }

  Widget _getCommentList(List<CommentModel> comments)
  {

  return  ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount:comments.length,
        itemBuilder: (BuildContext context, int index) {
          return _getCommentItem(comments[index]);
        });
  }

  Widget _getCommentItem(CommentModel model)
  {
    return Padding(padding: EdgeInsets.only(top: 8),child: RichText(
      text: TextSpan(

        children: [

          WidgetSpan(
            child: Container(
              margin: EdgeInsets.only(right: 8),
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: new NetworkImage(
                          TextsValue.sampleUserCommentImage))),
            ),
          ),
          TextSpan(text: model.user+': ',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),TextSpan(text: model.body,
            style: TextStyle(
                fontSize: 12,
                color: Colors.black),
          ),
        ],
      ),
    ));
  }


  _showDialog(BuildContext context,PostModel model,HomeViewModel homeViewModel) {

    showDialog<CommentModel>(
      context: context,
      builder: (BuildContext context) {
        return CommentView(postId: model.id);
      },
    ).then((CommentModel comment) {
      if(comment!=null)
        homeViewModel.updatePostComment(comment);
    });
  }


}
