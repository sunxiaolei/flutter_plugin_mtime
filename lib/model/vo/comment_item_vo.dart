class CommentItemVO {
  int commentId;
  bool isLong;
  String content;
  String headImg;
  String nickname;
  num rating;
  int commentDate;
  String title;

  CommentItemVO(this.isLong, this.commentId, this.content, this.headImg,
      this.nickname, this.rating, this.commentDate,
      {this.title});
}
