import 'package:flutter_plugin_mtime/model/dto/transform.dart';
import 'package:flutter_plugin_mtime/model/vo/comment_item_vo.dart';

class LongCommentDTO implements Transform<List<CommentItemVO>> {
  List<Comments> comments;
  int totalCount;

  LongCommentDTO({this.comments, this.totalCount});

  LongCommentDTO.fromJson(Map<String, dynamic> json) {
    if (json['comments'] != null) {
      comments = new List<Comments>();
      json['comments'].forEach((v) {
        comments.add(new Comments.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.comments != null) {
      data['comments'] = this.comments.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = this.totalCount;
    return data;
  }

  @override
  List<CommentItemVO> transform() {
    List<CommentItemVO> vos = List();
    if (comments != null) {
      vos = comments
          .map((c) => CommentItemVO(true, c.id, c.content, c.headurl,
              c.nickname, c.rating, c.modifyTime,
              title: c.title))
          .toList();
    }
    return vos;
  }
}

class Comments {
  int commentCount;
  String content;
  String headurl;
  int id;
  bool isWantSee;
  String location;
  int modifyTime;
  String nickname;
  num rating;
  String title;

  Comments(
      {this.commentCount,
      this.content,
      this.headurl,
      this.id,
      this.isWantSee,
      this.location,
      this.modifyTime,
      this.nickname,
      this.rating,
      this.title});

  Comments.fromJson(Map<String, dynamic> json) {
    commentCount = json['commentCount'];
    content = json['content'];
    headurl = json['headurl'];
    id = json['id'];
    isWantSee = json['isWantSee'];
    location = json['location'];
    modifyTime = json['modifyTime'];
    nickname = json['nickname'];
    rating = json['rating'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commentCount'] = this.commentCount;
    data['content'] = this.content;
    data['headurl'] = this.headurl;
    data['id'] = this.id;
    data['isWantSee'] = this.isWantSee;
    data['location'] = this.location;
    data['modifyTime'] = this.modifyTime;
    data['nickname'] = this.nickname;
    data['rating'] = this.rating;
    data['title'] = this.title;
    return data;
  }
}
