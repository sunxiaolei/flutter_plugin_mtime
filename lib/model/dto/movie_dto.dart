import 'package:flutter_plugin_mtime/model/dto/transform.dart';
import 'package:flutter_plugin_mtime/model/vo/actor_vo.dart';
import 'package:flutter_plugin_mtime/model/vo/director_vo.dart';
import 'package:flutter_plugin_mtime/model/vo/movie_vo.dart';

class MovieDTO implements Transform<MovieVO> {
  String code;
  Data data;
  String msg;
  String showMsg;

  MovieDTO({this.code, this.data, this.msg, this.showMsg});

  MovieDTO.fromJson(Map<String, dynamic> json) {
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
  MovieVO transform() {
    MovieVO vo = MovieVO(
      intro: data.basic.story,
      actors: data.basic.actors
          .map((a) => ActorVO(
                a.actorId,
                a.name,
                img: a.img,
                nameEn: a.nameEn,
                roleImg: a.roleImg,
                roleName: a.roleName,
              ))
          .toList(),
      director: DirectorVO(
        data.basic.director.directorId,
        data.basic.director.name,
        img: data.basic.director.img,
        nameEn: data.basic.director.nameEn,
      ),
    );
    return vo;
  }
}

class Data {
  Basic basic;
  BoxOffice boxOffice;
  Live live;
  String playState;
  List<Playlist> playlist;

  Data({this.basic, this.boxOffice, this.live, this.playState, this.playlist});

  Data.fromJson(Map<String, dynamic> json) {
    basic = json['basic'] != null ? new Basic.fromJson(json['basic']) : null;
    boxOffice = json['boxOffice'] != null
        ? new BoxOffice.fromJson(json['boxOffice'])
        : null;
    live = json['live'] != null ? new Live.fromJson(json['live']) : null;
    playState = json['playState'];
    if (json['playlist'] != null) {
      playlist = new List<Playlist>();
      json['playlist'].forEach((v) {
        if (v != null) {
          playlist.add(new Playlist.fromJson(v));
        }
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.basic != null) {
      data['basic'] = this.basic.toJson();
    }
    if (this.boxOffice != null) {
      data['boxOffice'] = this.boxOffice.toJson();
    }
    if (this.live != null) {
      data['live'] = this.live.toJson();
    }
    data['playState'] = this.playState;
    if (this.playlist != null) {
      data['playlist'] = this.playlist.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Basic {
  List<Actors> actors;
  Award award;
  String bigImage;
  String commentSpecial;
  Director director;
  num hotRanking;
  String img;
  bool is3D;
  bool isDMAX;
  bool isEggHunt;
  bool isFilter;
  bool isIMAX;
  bool isIMAX3D;
  bool isTicket;
  String message;
  String mins;
  num movieId;
  num movieStatus;
  String name;
  String nameEn;
  num overallRating;
  num personCount;
  String releaseArea;
  String releaseDate;
  bool sensitiveStatus;
  num showCinemaCount;
  num showDay;
  num showtimeCount;
  StageImg stageImg;
  String story;
  Style style;
  num totalNominateAward;
  num totalWinAward;
  List<String> type;
  String url;
  Video video;

  Basic(
      {this.actors,
      this.award,
      this.bigImage,
      this.commentSpecial,
      this.director,
      this.hotRanking,
      this.img,
      this.is3D,
      this.isDMAX,
      this.isEggHunt,
      this.isFilter,
      this.isIMAX,
      this.isIMAX3D,
      this.isTicket,
      this.message,
      this.mins,
      this.movieId,
      this.movieStatus,
      this.name,
      this.nameEn,
      this.overallRating,
      this.personCount,
      this.releaseArea,
      this.releaseDate,
      this.sensitiveStatus,
      this.showCinemaCount,
      this.showDay,
      this.showtimeCount,
      this.stageImg,
      this.story,
      this.style,
      this.totalNominateAward,
      this.totalWinAward,
      this.type,
      this.url,
      this.video});

  Basic.fromJson(Map<String, dynamic> json) {
    if (json['actors'] != null) {
      actors = new List<Actors>();
      json['actors'].forEach((v) {
        actors.add(new Actors.fromJson(v));
      });
    }
    award = json['award'] != null ? new Award.fromJson(json['award']) : null;
    bigImage = json['bigImage'];
    commentSpecial = json['commentSpecial'];
    director = json['director'] != null
        ? new Director.fromJson(json['director'])
        : null;
    hotRanking = json['hotRanking'];
    img = json['img'];
    is3D = json['is3D'];
    isDMAX = json['isDMAX'];
    isEggHunt = json['isEggHunt'];
    isFilter = json['isFilter'];
    isIMAX = json['isIMAX'];
    isIMAX3D = json['isIMAX3D'];
    isTicket = json['isTicket'];
    message = json['message'];
    mins = json['mins'];
    movieId = json['movieId'];
    movieStatus = json['movieStatus'];
    name = json['name'];
    nameEn = json['nameEn'];
    overallRating = json['overallRating'];
    personCount = json['personCount'];
    releaseArea = json['releaseArea'];
    releaseDate = json['releaseDate'];
    sensitiveStatus = json['sensitiveStatus'];
    showCinemaCount = json['showCinemaCount'];
    showDay = json['showDay'];
    showtimeCount = json['showtimeCount'];
    stageImg = json['stageImg'] != null
        ? new StageImg.fromJson(json['stageImg'])
        : null;
    story = json['story'];
    style = json['style'] != null ? new Style.fromJson(json['style']) : null;
    totalNominateAward = json['totalNominateAward'];
    totalWinAward = json['totalWinAward'];
    type = json['type'].cast<String>();
    url = json['url'];
    video = json['video'] != null ? new Video.fromJson(json['video']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.actors != null) {
      data['actors'] = this.actors.map((v) => v.toJson()).toList();
    }
    if (this.award != null) {
      data['award'] = this.award.toJson();
    }
    data['bigImage'] = this.bigImage;
    data['commentSpecial'] = this.commentSpecial;
    if (this.director != null) {
      data['director'] = this.director.toJson();
    }
    data['hotRanking'] = this.hotRanking;
    data['img'] = this.img;
    data['is3D'] = this.is3D;
    data['isDMAX'] = this.isDMAX;
    data['isEggHunt'] = this.isEggHunt;
    data['isFilter'] = this.isFilter;
    data['isIMAX'] = this.isIMAX;
    data['isIMAX3D'] = this.isIMAX3D;
    data['isTicket'] = this.isTicket;
    data['message'] = this.message;
    data['mins'] = this.mins;
    data['movieId'] = this.movieId;
    data['movieStatus'] = this.movieStatus;
    data['name'] = this.name;
    data['nameEn'] = this.nameEn;
    data['overallRating'] = this.overallRating;
    data['personCount'] = this.personCount;
    data['releaseArea'] = this.releaseArea;
    data['releaseDate'] = this.releaseDate;
    data['sensitiveStatus'] = this.sensitiveStatus;
    data['showCinemaCount'] = this.showCinemaCount;
    data['showDay'] = this.showDay;
    data['showtimeCount'] = this.showtimeCount;
    if (this.stageImg != null) {
      data['stageImg'] = this.stageImg.toJson();
    }
    data['story'] = this.story;
    if (this.style != null) {
      data['style'] = this.style.toJson();
    }
    data['totalNominateAward'] = this.totalNominateAward;
    data['totalWinAward'] = this.totalWinAward;
    data['type'] = this.type;
    data['url'] = this.url;
    if (this.video != null) {
      data['video'] = this.video.toJson();
    }
    return data;
  }
}

class Actors {
  int actorId;
  String img;
  String name;
  String nameEn;
  String roleImg;
  String roleName;

  Actors(
      {this.actorId,
      this.img,
      this.name,
      this.nameEn,
      this.roleImg,
      this.roleName});

  Actors.fromJson(Map<String, dynamic> json) {
    actorId = json['actorId'];
    img = json['img'];
    name = json['name'];
    nameEn = json['nameEn'];
    roleImg = json['roleImg'];
    roleName = json['roleName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['actorId'] = this.actorId;
    data['img'] = this.img;
    data['name'] = this.name;
    data['nameEn'] = this.nameEn;
    data['roleImg'] = this.roleImg;
    data['roleName'] = this.roleName;
    return data;
  }
}

class Award {
  List<String> awardList;
  num totalNominateAward;
  num totalWinAward;

  Award({this.awardList, this.totalNominateAward, this.totalWinAward});

  Award.fromJson(Map<String, dynamic> json) {
    if (json['awardList'] != null) {
      awardList = new List<String>();
      json['awardList'].forEach((v) {
        awardList.add(v);
      });
    }
    totalNominateAward = json['totalNominateAward'];
    totalWinAward = json['totalWinAward'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.awardList != null) {
      data['awardList'] = this.awardList;
    }
    data['totalNominateAward'] = this.totalNominateAward;
    data['totalWinAward'] = this.totalWinAward;
    return data;
  }
}

class Director {
  int directorId;
  String img;
  String name;
  String nameEn;

  Director({this.directorId, this.img, this.name, this.nameEn});

  Director.fromJson(Map<String, dynamic> json) {
    directorId = json['directorId'];
    img = json['img'];
    name = json['name'];
    nameEn = json['nameEn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['directorId'] = this.directorId;
    data['img'] = this.img;
    data['name'] = this.name;
    data['nameEn'] = this.nameEn;
    return data;
  }
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  return data;
}

class StageImg {
  num count;
  List<ListX> list;

  StageImg({this.count, this.list});

  StageImg.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = new List<ListX>();
      json['list'].forEach((v) {
        list.add(new ListX.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListX {
  int imgId;
  String imgUrl;

  ListX({this.imgId, this.imgUrl});

  ListX.fromJson(Map<String, dynamic> json) {
    imgId = json['imgId'];
    imgUrl = json['imgUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imgId'] = this.imgId;
    data['imgUrl'] = this.imgUrl;
    return data;
  }
}

class Style {
  int isLeadPage;
  String leadImg;
  String leadUrl;

  Style({this.isLeadPage, this.leadImg, this.leadUrl});

  Style.fromJson(Map<String, dynamic> json) {
    isLeadPage = json['isLeadPage'];
    leadImg = json['leadImg'];
    leadUrl = json['leadUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isLeadPage'] = this.isLeadPage;
    data['leadImg'] = this.leadImg;
    data['leadUrl'] = this.leadUrl;
    return data;
  }
}

class Video {
  int count;
  String hightUrl;
  String img;
  String title;
  String url;
  int videoId;
  num videoSourceType;

  Video(
      {this.count,
      this.hightUrl,
      this.img,
      this.title,
      this.url,
      this.videoId,
      this.videoSourceType});

  Video.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    hightUrl = json['hightUrl'];
    img = json['img'];
    title = json['title'];
    url = json['url'];
    videoId = json['videoId'];
    videoSourceType = json['videoSourceType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['hightUrl'] = this.hightUrl;
    data['img'] = this.img;
    data['title'] = this.title;
    data['url'] = this.url;
    data['videoId'] = this.videoId;
    data['videoSourceType'] = this.videoSourceType;
    return data;
  }
}

class BoxOffice {
  int movieId;
  num ranking;
  num todayBox;
  String todayBoxDes;
  String todayBoxDesUnit;
  num totalBox;
  String totalBoxDes;
  String totalBoxUnit;

  BoxOffice(
      {this.movieId,
      this.ranking,
      this.todayBox,
      this.todayBoxDes,
      this.todayBoxDesUnit,
      this.totalBox,
      this.totalBoxDes,
      this.totalBoxUnit});

  BoxOffice.fromJson(Map<String, dynamic> json) {
    movieId = json['movieId'];
    ranking = json['ranking'];
    todayBox = json['todayBox'];
    todayBoxDes = json['todayBoxDes'];
    todayBoxDesUnit = json['todayBoxDesUnit'];
    totalBox = json['totalBox'];
    totalBoxDes = json['totalBoxDes'];
    totalBoxUnit = json['totalBoxUnit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['movieId'] = this.movieId;
    data['ranking'] = this.ranking;
    data['todayBox'] = this.todayBox;
    data['todayBoxDes'] = this.todayBoxDes;
    data['todayBoxDesUnit'] = this.todayBoxDesUnit;
    data['totalBox'] = this.totalBox;
    data['totalBoxDes'] = this.totalBoxDes;
    data['totalBoxUnit'] = this.totalBoxUnit;
    return data;
  }
}

class Live {
  int count;
  String img;
  int liveId;
  String playNumTag;
  String playTag;
  int status;
  String title;

  Live(
      {this.count,
      this.img,
      this.liveId,
      this.playNumTag,
      this.playTag,
      this.status,
      this.title});

  Live.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    img = json['img'];
    liveId = json['liveId'];
    playNumTag = json['playNumTag'];
    playTag = json['playTag'];
    status = json['status'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['img'] = this.img;
    data['liveId'] = this.liveId;
    data['playNumTag'] = this.playNumTag;
    data['playTag'] = this.playTag;
    data['status'] = this.status;
    data['title'] = this.title;
    return data;
  }
}

class Playlist {
  bool isOpenByBrowser;
  String payRule;
  String picUrl;
  String playSourceName;
  String playUrl;
  String playUrlH5;
  String playUrlPC;
  String sourceId;

  Playlist(
      {this.isOpenByBrowser,
      this.payRule,
      this.picUrl,
      this.playSourceName,
      this.playUrl,
      this.playUrlH5,
      this.playUrlPC,
      this.sourceId});

  Playlist.fromJson(Map<String, dynamic> json) {
    isOpenByBrowser = json['isOpenByBrowser'];
    payRule = json['payRule'];
    picUrl = json['picUrl'];
    playSourceName = json['playSourceName'];
    playUrl = json['playUrl'];
    playUrlH5 = json['playUrlH5'];
    playUrlPC = json['playUrlPC'];
    sourceId = json['sourceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isOpenByBrowser'] = this.isOpenByBrowser;
    data['payRule'] = this.payRule;
    data['picUrl'] = this.picUrl;
    data['playSourceName'] = this.playSourceName;
    data['playUrl'] = this.playUrl;
    data['playUrlH5'] = this.playUrlH5;
    data['playUrlPC'] = this.playUrlPC;
    data['sourceId'] = this.sourceId;
    return data;
  }
}

class Related {
  num goodsCount;
  List<String> goodsList;
  num relateId;
  String relatedUrl;
  num type;

  Related(
      {this.goodsCount,
      this.goodsList,
      this.relateId,
      this.relatedUrl,
      this.type});

  Related.fromJson(Map<String, dynamic> json) {
    goodsCount = json['goodsCount'];
    if (json['goodsList'] != null) {
      goodsList = new List<Null>();
      json['goodsList'].forEach((v) {
        goodsList.add(v);
      });
    }
    relateId = json['relateId'];
    relatedUrl = json['relatedUrl'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goodsCount'] = this.goodsCount;
    if (this.goodsList != null) {
      data['goodsList'] = this.goodsList;
    }
    data['relateId'] = this.relateId;
    data['relatedUrl'] = this.relatedUrl;
    data['type'] = this.type;
    return data;
  }
}
