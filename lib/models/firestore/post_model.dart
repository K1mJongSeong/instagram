class PostModel{
  final String postKey;
  final String userKey;
  final String userName;
  final String postImg;
  final List<dynamic> numOfLikes;
  final String caption;
  final String lastcommentor;
  final String lastcomment;
  final String lastcommenttime;
  final String numOfcomments;
  final String posttime;

  PostModel(this.postKey, this.userKey, this.userName, this.postImg, this.numOfLikes, this.caption, this.lastcommentor, this.lastcomment, this.lastcommenttime, this.numOfcomments, this.posttime);

}