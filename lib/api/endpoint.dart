class EndPoint {

  static final String _base = "api/v1/";
  static final String post =_base+ "post";
  static final String comment =_base+ "post";

  static String getCommentUrl(String postId)
  {
    return post+'/'+postId+'/comment';
  }

}
