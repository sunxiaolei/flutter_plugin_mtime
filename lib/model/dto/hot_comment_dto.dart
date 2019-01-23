import 'package:flutter_plugin_mtime/model/dto/transform.dart';
import 'package:flutter_plugin_mtime/model/vo/comment_item_vo.dart';
import 'package:flutter_plugin_mtime/model/vo/hot_comment_vo.dart';

class HotCommentDTO implements Transform<HotCommentVO> {
  String code;
  Data data;
  String msg;
  String showMsg;

  HotCommentDTO({this.code, this.data, this.msg, this.showMsg});

  HotCommentDTO.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    msg = json['msg'];
    showMsg = json['showMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['msg'] = this.msg;
    data['showMsg'] = this.showMsg;
    return data;
  }

  @override
  HotCommentVO transform() {
    HotCommentVO vo = HotCommentVO(
        data.mini.list
            .map((dto) => CommentItemVO(false, dto.commentId, dto.content,
                dto.headImg, dto.nickname, dto.rating, dto.commentDate))
            .toList(),
        data.plus.list
            .map((dto) => CommentItemVO(true, dto.commentId, dto.content,
                dto.headImg, dto.nickname, dto.rating, dto.commentDate,
                title: dto.title))
            .toList());
    return vo;
  }
}

class Data {
  Mini mini;
  Plus plus;

  Data({this.mini, this.plus});

  Data.fromJson(Map<String, dynamic> json) {
    mini = json['mini'] != null ? new Mini.fromJson(json['mini']) : null;
    plus = json['plus'] != null ? new Plus.fromJson(json['plus']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mini != null) {
      data['mini'] = this.mini.toJson();
    }
    if (this.plus != null) {
      data['plus'] = this.plus.toJson();
    }
    return data;
  }
}

class Mini {
  List<ListX> list;
  int total;

  Mini({this.list, this.total});

  Mini.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = new List<ListX>();
      json['list'].forEach((v) {
        list.add(new ListX.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}

class ListX {
  int commentDate;
  int commentId;
  String content;
  String headImg;
  String img;
  bool isHot;
  bool isPraise;
  String locationName;
  String nickname;
  int praiseCount;
  num rating;
  int replyCount;
  String title;

  ListX(
      {this.commentDate,
      this.commentId,
      this.content,
      this.headImg,
      this.img,
      this.isHot,
      this.isPraise,
      this.locationName,
      this.nickname,
      this.praiseCount,
      this.rating,
      this.replyCount,
      this.title});

  ListX.fromJson(Map<String, dynamic> json) {
    commentDate = json['commentDate'];
    commentId = json['commentId'];
    content = json['content'];
    headImg = json['headImg'];
    img = json['img'];
    isHot = json['isHot'];
    isPraise = json['isPraise'];
    locationName = json['locationName'];
    nickname = json['nickname'];
    praiseCount = json['praiseCount'];
    rating = json['rating'];
    replyCount = json['replyCount'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commentDate'] = this.commentDate;
    data['commentId'] = this.commentId;
    data['content'] = this.content;
    data['headImg'] = this.headImg;
    data['img'] = this.img;
    data['isHot'] = this.isHot;
    data['isPraise'] = this.isPraise;
    data['locationName'] = this.locationName;
    data['nickname'] = this.nickname;
    data['praiseCount'] = this.praiseCount;
    data['rating'] = this.rating;
    data['replyCount'] = this.replyCount;
    data['title'] = this.title;
    return data;
  }
}

class Plus {
  List<ListX> list;
  int total;

  Plus({this.list, this.total});

  Plus.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = new List<ListX>();
      json['list'].forEach((v) {
        list.add(new ListX.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}
