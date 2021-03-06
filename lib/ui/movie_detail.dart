import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_base/constant/pagestatus.dart';
import 'package:flutter_plugin_base/utils/log_utils.dart';
import 'package:flutter_plugin_mtime/constant/colors.dart';
import 'package:flutter_plugin_mtime/model/vo/comment_item_vo.dart';
import 'package:flutter_plugin_mtime/model/vo/hot_comment_vo.dart';
import 'package:flutter_plugin_mtime/model/vo/movie_item_vo.dart';
import 'package:flutter_plugin_mtime/model/vo/movie_vo.dart';
import 'package:flutter_plugin_mtime/net/api.dart';
import 'package:flutter_plugin_mtime/net/request.dart';
import 'package:flutter_plugin_mtime/ui/comment_list.dart';
import 'package:flutter_plugin_mtime/ui/common_utils.dart';
import 'package:flutter_plugin_mtime/ui/img.dart';
import 'package:flutter_plugin_mtime/ui/web.dart';
import 'package:flutter_plugin_mtime/widget/rating.dart';
import 'package:palette_generator/palette_generator.dart';

class MoviePage extends StatefulWidget {
  final MovieItemVO movieItemVO;

  const MoviePage(
    this.movieItemVO, {
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MovieState();
  }
}

class MovieState extends State<MoviePage> {
  Color _colorBg = Mcolors.windowBackground;

  PageStatus detailStatus = PageStatus.LOADING;
  PageStatus commentStatus = PageStatus.LOADING;
  MovieVO _movie;
  HotCommentVO _hotComment;

  @override
  void initState() {
    super.initState();
    _updatePaletteGenerator();
    _getMovieData();
    _getHotComment();
  }

  //更新背景
  _updatePaletteGenerator() async {
    PaletteGenerator pg = await PaletteGenerator.fromImageProvider(
        CachedNetworkImageProvider(
            CommonUtils.getImgSmall(widget.movieItemVO.img)));
    _colorBg = pg.dominantColor?.color;
    setState(() {});
  }

  //获取电影详情
  _getMovieData() async {
    Request().getMovieDetail(widget.movieItemVO.id).then((movie) {
      _movie = movie;
      setState(() {
        detailStatus = PageStatus.DATA;
      });
    }).catchError((error) {
      Log.i(error.toString());
      setState(() {
        detailStatus = PageStatus.ERROR;
      });
    });
  }

  //获取热门评论
  _getHotComment() async {
    Request().getMovieHotComment(widget.movieItemVO.id).then((comment) {
      _hotComment = comment;
      setState(() {
        commentStatus = PageStatus.DATA;
      });
    }).catchError((error) {
      Log.i(error.toString());
      setState(() {
        commentStatus = PageStatus.ERROR;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _colorBg,
      appBar: _buildBar(),
      body: Stack(
        children: <Widget>[
          Container(
            color: const Color(0x44000000),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _builHead(),
                widget.movieItemVO.t == 0 ? _buildRate() : SizedBox(),
                _buildDetail(),
                _buildHotComment(),
              ],
            ),
          )
        ],
      ),
    );
  }

  //标题
  _buildBar() {
    return AppBar(
      title: Text('电影'),
      elevation: 0,
      backgroundColor: const Color(0x44000000),
    );
  }

  //上半部
  _builHead() {
    DateTime showTime = DateTime.parse(widget.movieItemVO.showTime);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ImagePage(widget.movieItemVO.img)));
            },
            child: Hero(
                tag: widget.movieItemVO.img + widget.movieItemVO.t.toString(),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: CachedNetworkImage(
                    imageUrl: CommonUtils.getImgMid(widget.movieItemVO.img),
                    fit: BoxFit.fitHeight,
                    height: 200,
                  ),
                )),
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.movieItemVO.name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.movieItemVO.nameEn == null
                    ? '(' + widget.movieItemVO.year + ')'
                    : widget.movieItemVO.nameEn +
                        '(' +
                        widget.movieItemVO.year +
                        ')',
                style: TextStyle(fontSize: 15),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.movieItemVO.during == null
                    ? ''
                    : widget.movieItemVO.during + '分钟',
                style: TextStyle(fontSize: 12, color: Colors.white70),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                showTime.year.toString() +
                    '年' +
                    showTime.month.toString() +
                    '月' +
                    showTime.day.toString() +
                    '日中国上映',
                style: TextStyle(fontSize: 12, color: Colors.white70),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.movieItemVO.type,
                style: TextStyle(fontSize: 12, color: Colors.white54),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.movieItemVO.commonSpecial == null
                    ? ''
                    : widget.movieItemVO.commonSpecial,
                style: TextStyle(fontSize: 12, color: Colors.orange),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              )
            ],
          ),
        ))
      ],
    );
  }

  //评分
  _buildRate() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        color: Color(0x77000000),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '时光评分',
            style: TextStyle(fontSize: 12, color: Colors.white54),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                widget.movieItemVO.rate > 0
                    ? widget.movieItemVO.rate.toString()
                    : '--',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Rating(
                widget.movieItemVO.rate,
                color: Colors.yellow,
              )
            ],
          ),
        ],
      ),
    );
  }

  //详细信息
  _buildDetail() {
    switch (detailStatus) {
      case PageStatus.DATA:
        return Column(
          children: <Widget>[
            _buildIntro(),
            _buildActors(),
          ],
        );
        break;
      case PageStatus.LOADING:
      case PageStatus.EMPTY:
      case PageStatus.ERROR:
        return SizedBox();
        break;
    }
  }

  //简介
  _buildIntro() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '简介',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            _movie.intro,
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }

  //演职员
  _buildActors() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '演职员',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 220,
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index == 0
                    ? _buildActorCard(_movie.director.name,
                        _movie.director.nameEn, _movie.director.img, '（导演）')
                    : _buildActorCard(
                        _movie.actors[index - 1].name,
                        _movie.actors[index - 1].nameEn,
                        _movie.actors[index - 1].img,
                        '饰（' + _movie.actors[index - 1].roleName + '）',
                      );
              },
              itemCount: _movie.actors == null ? 0 : _movie.actors.length + 1,
              scrollDirection: Axis.horizontal,
            ),
          )
        ],
      ),
    );
  }

  _buildActorCard(String name, String nameEn, String imgUrl, String roleName) {
    return InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ImagePage(imgUrl)));
        },
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            width: 120,
            child: Column(children: <Widget>[
              Hero(
                  tag: imgUrl,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    child: CachedNetworkImage(
                      imageUrl: CommonUtils.getImgMid(imgUrl),
                      errorWidget: Container(
                        child: Center(
                          child: Icon(Icons.error),
                        ),
                        height: 160,
                      ),
                      placeholder: Container(
                        child: Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ),
                        ),
                        height: 160,
                      ),
                      fit: BoxFit.fitHeight,
                      height: 160,
                    ),
                  )),
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: Text(
                  name.isEmpty ? nameEn : name,
                  style: TextStyle(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              roleName.isEmpty
                  ? SizedBox()
                  : Center(
                      child: Text(
                        roleName,
                        style: TextStyle(fontSize: 12, color: Colors.white70),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    )
            ])));
  }

  //热门评论
  _buildHotComment() {
    switch (commentStatus) {
      case PageStatus.DATA:
        return Column(
          children: <Widget>[
            _hotComment.listShort.length == 0
                ? SizedBox()
                : _buildShortCommentList(),
            _hotComment.listLong.length == 0
                ? SizedBox()
                : _buildLongCommentList(),
          ],
        );
        break;
      case PageStatus.LOADING:
      case PageStatus.EMPTY:
      case PageStatus.ERROR:
        return SizedBox();
        break;
    }
  }

  //短评列表
  _buildShortCommentList() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        padding: EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Color(0x77000000),
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 15.0),
              decoration: BoxDecoration(
                color: Color(0x55424242),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '短评',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 15.0),
                      child: Text('全部>'),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CommentList(
                                  widget.movieItemVO.id,
                                  widget.movieItemVO.name,
                                  false)));
                    },
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return _buildShortComment(_hotComment.listShort[index]);
              },
              itemCount: _hotComment.listShort.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            )
          ],
        ));
  }

  //短评
  _buildShortComment(CommentItemVO comment) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(comment.headImg),
                radius: 20.0,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(comment.nickname),
                  Rating(
                    comment.rating,
                    color: Colors.yellow,
                    size: 13,
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(comment.content),
          Divider(
            color: Colors.white54,
          )
        ],
      ),
    );
  }

  //长评列表
  _buildLongCommentList() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 15.0),
            decoration: BoxDecoration(
              color: Color(0x55424242),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '长评',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                InkWell(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
                    child: Text('全部>'),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CommentList(
                                widget.movieItemVO.id,
                                widget.movieItemVO.name,
                                true)));
                  },
                )
              ],
            ),
          ),
          ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return _buildLongComment(_hotComment.listLong[index]);
            },
            itemCount: _hotComment.listLong.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
          )
        ],
      ),
    );
  }

  //长评
  _buildLongComment(CommentItemVO comment) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Color(0x77000000),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            comment.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(comment.headImg),
                radius: 20.0,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(comment.nickname),
                  Rating(
                    comment.rating,
                    color: Colors.yellow,
                    size: 13,
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(comment.content),
          Center(
            child: FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WebPage(Api.commentDetail(
                              widget.movieItemVO.id, comment.commentId))));
                },
                child: Text('MORE >>')),
          ),
          Divider(
            color: Colors.white54,
          )
        ],
      ),
    );
  }
}
