import 'package:flutter_plugin_mtime/model/dto/transform.dart';
import 'package:flutter_plugin_mtime/model/vo/movie_item_vo.dart';

class HotMoviesDTO implements Transform<List<MovieItemVO>> {
  String bImg;
  String date;
  bool hasPromo;
  int lid;
  List<Ms> ms;
  int newActivitiesTime;
  int totalComingMovie;
  String voucherMsg;

  HotMoviesDTO(
      {this.bImg,
      this.date,
      this.hasPromo,
      this.lid,
      this.ms,
      this.newActivitiesTime,
      this.totalComingMovie,
      this.voucherMsg});

  HotMoviesDTO.fromJson(Map<String, dynamic> json) {
    bImg = json['bImg'];
    date = json['date'];
    hasPromo = json['hasPromo'];
    lid = json['lid'];
    if (json['ms'] != null) {
      ms = new List<Ms>();
      json['ms'].forEach((v) {
        ms.add(new Ms.fromJson(v));
      });
    }
    newActivitiesTime = json['newActivitiesTime'];
    totalComingMovie = json['totalComingMovie'];
    voucherMsg = json['voucherMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bImg'] = this.bImg;
    data['date'] = this.date;
    data['hasPromo'] = this.hasPromo;
    data['lid'] = this.lid;
    if (this.ms != null) {
      data['ms'] = this.ms.map((v) => v.toJson()).toList();
    }
    data['newActivitiesTime'] = this.newActivitiesTime;
    data['totalComingMovie'] = this.totalComingMovie;
    data['voucherMsg'] = this.voucherMsg;
    return data;
  }

  @override
  List<MovieItemVO> transform() {
    List<MovieItemVO> vos = List();
    if (ms != null) {
      vos = ms
          .map((ms) => MovieItemVO(
                ms.id,
                0,
                ms.t,
                ms.img,
                ms.movieType,
                ms.year,
                ms.rd,
                versions: ms.versions.map((v) => v.version).toList(),
                commonSpecial: ms.commonSpecial,
                rate: ms.r,
                nameEn: ms.tEn,
                during: ms.d,
              ))
          .toList();
    }
    return vos;
  }
}

class Ms {
  int nearestCinemaCount;
  int nearestDay;
  int nearestShowtimeCount;
  String aN1;
  String aN2;
  String actors;
  int cC;
  String commonSpecial;
  String d;
  String dN;
  int def;
  int id;
  String img;
  bool is3D;
  bool isDMAX;
  bool isFilter;
  bool isHasTrailer;
  bool isHot;
  bool isIMAX;
  bool isIMAX3D;
  bool isNew;
  bool isTicket;
  String m;
  int movieId;
  String movieType;
  List<String> p;
  bool preferentialFlag;
  num r;
  int rc;
  String rd;
  int rsC;
  int sC;
  String t;
  String tCn;
  String tEn;
  int ua;
  List<Versions> versions;
  int wantedCount;
  String year;

  Ms(
      {this.nearestCinemaCount,
      this.nearestDay,
      this.nearestShowtimeCount,
      this.aN1,
      this.aN2,
      this.actors,
      this.cC,
      this.commonSpecial,
      this.d,
      this.dN,
      this.def,
      this.id,
      this.img,
      this.is3D,
      this.isDMAX,
      this.isFilter,
      this.isHasTrailer,
      this.isHot,
      this.isIMAX,
      this.isIMAX3D,
      this.isNew,
      this.isTicket,
      this.m,
      this.movieId,
      this.movieType,
      this.p,
      this.preferentialFlag,
      this.r,
      this.rc,
      this.rd,
      this.rsC,
      this.sC,
      this.t,
      this.tCn,
      this.tEn,
      this.ua,
      this.versions,
      this.wantedCount,
      this.year});

  Ms.fromJson(Map<String, dynamic> json) {
    nearestCinemaCount = json['NearestCinemaCount'];
    nearestDay = json['NearestDay'];
    nearestShowtimeCount = json['NearestShowtimeCount'];
    aN1 = json['aN1'];
    aN2 = json['aN2'];
    actors = json['actors'];
    cC = json['cC'];
    commonSpecial = json['commonSpecial'];
    d = json['d'];
    dN = json['dN'];
    def = json['def'];
    id = json['id'];
    img = json['img'].toString();
    is3D = json['is3D'];
    isDMAX = json['isDMAX'];
    isFilter = json['isFilter'];
    isHasTrailer = json['isHasTrailer'];
    isHot = json['isHot'];
    isIMAX = json['isIMAX'];
    isIMAX3D = json['isIMAX3D'];
    isNew = json['isNew'];
    isTicket = json['isTicket'];
    m = json['m'];
    movieId = json['movieId'];
    movieType = json['movieType'];
    p = json['p'].cast<String>();
    preferentialFlag = json['preferentialFlag'];
    r = json['r'];
    rc = json['rc'];
    rd = json['rd'];
    rsC = json['rsC'];
    sC = json['sC'];
    t = json['t'];
    tCn = json['tCn'];
    tEn = json['tEn'];
    ua = json['ua'];
    if (json['versions'] != null) {
      versions = new List<Versions>();
      json['versions'].forEach((v) {
        versions.add(new Versions.fromJson(v));
      });
    }
    wantedCount = json['wantedCount'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NearestCinemaCount'] = this.nearestCinemaCount;
    data['NearestDay'] = this.nearestDay;
    data['NearestShowtimeCount'] = this.nearestShowtimeCount;
    data['aN1'] = this.aN1;
    data['aN2'] = this.aN2;
    data['actors'] = this.actors;
    data['cC'] = this.cC;
    data['commonSpecial'] = this.commonSpecial;
    data['d'] = this.d;
    data['dN'] = this.dN;
    data['def'] = this.def;
    data['id'] = this.id;
    data['img'] = this.img;
    data['is3D'] = this.is3D;
    data['isDMAX'] = this.isDMAX;
    data['isFilter'] = this.isFilter;
    data['isHasTrailer'] = this.isHasTrailer;
    data['isHot'] = this.isHot;
    data['isIMAX'] = this.isIMAX;
    data['isIMAX3D'] = this.isIMAX3D;
    data['isNew'] = this.isNew;
    data['isTicket'] = this.isTicket;
    data['m'] = this.m;
    data['movieId'] = this.movieId;
    data['movieType'] = this.movieType;
    data['p'] = this.p;
    data['preferentialFlag'] = this.preferentialFlag;
    data['r'] = this.r;
    data['rc'] = this.rc;
    data['rd'] = this.rd;
    data['rsC'] = this.rsC;
    data['sC'] = this.sC;
    data['t'] = this.t;
    data['tCn'] = this.tCn;
    data['tEn'] = this.tEn;
    data['ua'] = this.ua;
    if (this.versions != null) {
      data['versions'] = this.versions.map((v) => v.toJson()).toList();
    }
    data['wantedCount'] = this.wantedCount;
    data['year'] = this.year;
    return data;
  }
}

class Versions {
  int enumX;
  String version;

  Versions({this.enumX, this.version});

  Versions.fromJson(Map<String, dynamic> json) {
    enumX = json['enum'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enum'] = this.enumX;
    data['version'] = this.version;
    return data;
  }
}
