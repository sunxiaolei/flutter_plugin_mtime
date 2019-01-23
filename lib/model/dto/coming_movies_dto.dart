import 'package:flutter_plugin_mtime/model/dto/transform.dart';
import 'package:flutter_plugin_mtime/model/vo/movie_item_vo.dart';

class ComingDTO implements Transform<List<MovieItemVO>> {
  List<Moviecomings> moviecomings;

  ComingDTO({this.moviecomings});

  ComingDTO.fromJson(Map<String, dynamic> json) {
    if (json['moviecomings'] != null) {
      moviecomings = new List<Moviecomings>();
      json['moviecomings'].forEach((v) {
        moviecomings.add(new Moviecomings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.moviecomings != null) {
      data['moviecomings'] = this.moviecomings.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  List<MovieItemVO> transform() {
    List<MovieItemVO> vos = List();
    if (moviecomings != null) {
      vos = moviecomings
          .map((coming) => MovieItemVO(
              coming.id,
              1,
              coming.title,
              coming.image,
              coming.type,
              coming.rYear.toString(),
              DateTime(coming.rYear, coming.rMonth, coming.rDay)
                  .toIso8601String(),
              showTimeStr: coming.releaseDate))
          .toList();
    }
    return vos;
  }
}

class Videos {
  String hightUrl;
  String image;
  int length;
  String title;
  String url;
  int videoId;

  Videos(
      {this.hightUrl,
      this.image,
      this.length,
      this.title,
      this.url,
      this.videoId});

  Videos.fromJson(Map<String, dynamic> json) {
    hightUrl = json['hightUrl'];
    image = json['image'];
    length = json['length'];
    title = json['title'];
    url = json['url'];
    videoId = json['videoId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hightUrl'] = this.hightUrl;
    data['image'] = this.image;
    data['length'] = this.length;
    data['title'] = this.title;
    data['url'] = this.url;
    data['videoId'] = this.videoId;
    return data;
  }
}

class Moviecomings {
  String actor1;
  String actor2;
  String director;
  int id;
  String image;
  bool isFilter;
  bool isTicket;
  bool isVideo;
  String locationName;
  int rDay;
  int rMonth;
  int rYear;
  String releaseDate;
  String title;
  String type;
  int videoCount;
  List<Videos> videos;
  int wantedCount;

  Moviecomings(
      {this.actor1,
      this.actor2,
      this.director,
      this.id,
      this.image,
      this.isFilter,
      this.isTicket,
      this.isVideo,
      this.locationName,
      this.rDay,
      this.rMonth,
      this.rYear,
      this.releaseDate,
      this.title,
      this.type,
      this.videoCount,
      this.videos,
      this.wantedCount});

  Moviecomings.fromJson(Map<String, dynamic> json) {
    actor1 = json['actor1'];
    actor2 = json['actor2'];
    director = json['director'];
    id = json['id'];
    image = json['image'];
    isFilter = json['isFilter'];
    isTicket = json['isTicket'];
    isVideo = json['isVideo'];
    locationName = json['locationName'];
    rDay = json['rDay'];
    rMonth = json['rMonth'];
    rYear = json['rYear'];
    releaseDate = json['releaseDate'];
    title = json['title'];
    type = json['type'];
    videoCount = json['videoCount'];
    if (json['videos'] != null) {
      videos = new List<Videos>();
      json['videos'].forEach((v) {
        videos.add(new Videos.fromJson(v));
      });
    }
    wantedCount = json['wantedCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['actor1'] = this.actor1;
    data['actor2'] = this.actor2;
    data['director'] = this.director;
    data['id'] = this.id;
    data['image'] = this.image;
    data['isFilter'] = this.isFilter;
    data['isTicket'] = this.isTicket;
    data['isVideo'] = this.isVideo;
    data['locationName'] = this.locationName;
    data['rDay'] = this.rDay;
    data['rMonth'] = this.rMonth;
    data['rYear'] = this.rYear;
    data['releaseDate'] = this.releaseDate;
    data['title'] = this.title;
    data['type'] = this.type;
    data['videoCount'] = this.videoCount;
    if (this.videos != null) {
      data['videos'] = this.videos.map((v) => v.toJson()).toList();
    }
    data['wantedCount'] = this.wantedCount;
    return data;
  }
}
