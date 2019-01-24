import 'package:flutter_plugin_mtime/model/dto/transform.dart';
import 'package:flutter_plugin_mtime/model/vo/comment_item_vo.dart';

class ShortCommentDTO implements Transform<List<CommentItemVO>> {
  String code;
  Data data;
  String msg;
  String showMsg;

  ShortCommentDTO({this.code, this.data, this.msg, this.showMsg});

  ShortCommentDTO.fromJson(Map<String, dynamic> json) {
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
  List<CommentItemVO> transform() {
    List<CommentItemVO> vos = List();
    if (data?.cts != null) {
      vos = data.cts
          .map((cts) => CommentItemVO(
              false, cts.tweetId, cts.ce, cts.caimg, cts.ca, cts.cr, cts.cd))
          .toList();
    }
    return vos;
  }
}

class Data {
  List<Cts> cts;
  int totalCount;
  int tpc;

  Data({this.cts, this.totalCount, this.tpc});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['cts'] != null) {
      cts = new List<Cts>();
      json['cts'].forEach((v) {
        cts.add(new Cts.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
    tpc = json['tpc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cts != null) {
      data['cts'] = this.cts.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = this.totalCount;
    data['tpc'] = this.tpc;
    return data;
  }
}

class Cts {
  String ca;
  String caimg;
  String cal;
  int cd;
  String ce;
  String ceimg;
  int commentCount;
  num cr;
  bool isHot;
  int tweetId;

  Cts(
      {this.ca,
      this.caimg,
      this.cal,
      this.cd,
      this.ce,
      this.ceimg,
      this.commentCount,
      this.cr,
      this.isHot,
      this.tweetId});

  Cts.fromJson(Map<String, dynamic> json) {
    ca = json['ca'];
    caimg = json['caimg'];
    cal = json['cal'];
    cd = json['cd'];
    ce = json['ce'];
    ceimg = json['ceimg'];
    commentCount = json['commentCount'];
    cr = json['cr'];
    isHot = json['isHot'];
    tweetId = json['tweetId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ca'] = this.ca;
    data['caimg'] = this.caimg;
    data['cal'] = this.cal;
    data['cd'] = this.cd;
    data['ce'] = this.ce;
    data['ceimg'] = this.ceimg;
    data['commentCount'] = this.commentCount;
    data['cr'] = this.cr;
    data['isHot'] = this.isHot;
    data['tweetId'] = this.tweetId;
    return data;
  }
}
