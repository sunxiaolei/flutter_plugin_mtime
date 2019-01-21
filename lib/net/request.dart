import 'package:dio/dio.dart';
import 'package:flutter_plugin_mtime/model/dto/hot_movies_dto.dart';
import 'package:flutter_plugin_mtime/model/dto/movie_dto.dart';
import 'package:flutter_plugin_mtime/model/vo/movie_item_vo.dart';
import 'package:flutter_plugin_mtime/model/vo/movie_vo.dart';
import 'package:flutter_plugin_mtime/net/api.dart';
import 'package:flutter_plugin_mtime/net/interceptor.dart';

class Request {
  Dio _dio;

  Request() {
    Options options = Options(connectTimeout: 10000);
    _dio = Dio(options);
    LogInterceptor interceptor = LogInterceptor();
    _dio.interceptor.request.onSend = interceptor.onSend;
    _dio.interceptor.response.onSuccess = interceptor.onSuccess;
    _dio.interceptor.response.onError = interceptor.onError;
  }

  //正在热映
  Future<List<MovieItemVO>> getHotMovies() async {
    String reqAPi = Api.homelist;
    Response response = await _dio.get(reqAPi, data: {'locationId': 290});
    return HotMoviesDTO.fromJson(response.data).transform();
  }

  //正在热映
  Future<MovieVO> getMovieDetail(movieId) async {
    String reqAPi = Api.getMovie;
    Response response =
        await _dio.get(reqAPi, data: {'locationId': 290, 'movieId': movieId});
    return MovieDTO.fromJson(response.data).transform();
  }
}
