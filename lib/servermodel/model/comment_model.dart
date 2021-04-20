class CommentModel {
  String id;
  String postId;
  String createdAt;
  String user;
  String body;

  CommentModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        postId = json["postId"],
        createdAt = json["createdAt"],
        user = json["user"],
        body = json["body"];

  Map<String, dynamic> toJson() => {
    'id': id,
    'postId': postId,
    'createdAt': createdAt,
    'user': user,
    'body': body,
  };
}
