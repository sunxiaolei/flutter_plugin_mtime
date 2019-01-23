class MovieItemVO {
  int id;
  int t; //0:热映 1:Coming
  String name; //名称
  String nameEn; //英文名
  String img; //海报地址
  num rate; //评分
  List<String> versions; //上映版本
  String type; //影片类型
  String commonSpecial; //一句话评论
  String year; //年份
  String showTime; //上映日期
  String showTimeStr; //上映日期
  String during; //片长

  MovieItemVO(
    this.id,
    this.t,
    this.name,
    this.img,
    this.type,
    this.year,
    this.showTime, {
    this.rate,
    this.nameEn,
    this.versions,
    this.commonSpecial,
    this.during,
    this.showTimeStr,
  });
}
