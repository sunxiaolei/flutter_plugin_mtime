import 'package:flutter_plugin_mtime/model/vo/actor_vo.dart';
import 'package:flutter_plugin_mtime/model/vo/director_vo.dart';

class MovieVO {
  int movieId;
  String name;
  String nameEn;
  num rate;
  String intro;
  List<ActorVO> actors;
  DirectorVO director;

  MovieVO(
      {this.movieId,
      this.name,
      this.nameEn,
      this.rate,
      this.intro,
      this.actors,
      this.director});
}
