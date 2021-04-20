

import 'comment_model.dart';

class PostModel {
  final String id;
  final String createdAt;
  final int views;
  final bool published;
  final String title;
  final List<CommentModel> comments;

  PostModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        createdAt = json["createdAt"],
        views = json["views"],
        published = json["published"],
        title = json["title"],
        comments = json["comments"] != null
            ?  (json['comments'] as List)
            .map((contentItem) => CommentModel.fromJson(contentItem))
            .toList()
            : [];

  Map<String, dynamic> toJson() => {
        'id': id,
        'createdAt': createdAt,
        'views': views,
        'published': published,
        'title': title,
        'comments': comments != null ? comments.map((e) => e.toJson()).toList() : null,
      };


}
