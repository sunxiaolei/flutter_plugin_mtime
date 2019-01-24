class Api {
  //正在热映
  static String hotlist = 'https://api-m.mtime.cn/Showtime/LocationMovies.api';

  //即将上映
  static String cominglist = 'https://api-m.mtime.cn/Movie/MovieComingNew.api';

  //影片详情
  static String getMovie = 'https://ticket-api-m.mtime.cn/movie/detail.api';

  //热门影评
  static String getMovieHotComment =
      'https://ticket-api-m.mtime.cn/movie/hotComment.api';

  //短评
  static String getMovieShortComment =
      'https://api-m.mtime.cn/Showtime/HotMovieComments.api';

  //长评
  static String getMovieLongComment =
      'https://api-m.mtime.cn/Movie/HotLongComments.api';

  static String commentDetail(int movieId, int commentId) {
    return 'http://movie.mtime.com/$movieId/reviews/$commentId.html';
  }
}
