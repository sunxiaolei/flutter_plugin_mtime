import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_base/constant/pagestatus.dart';
import 'package:flutter_plugin_base/utils/log_utils.dart';
import 'package:flutter_plugin_mtime/constant/colors.dart';
import 'package:flutter_plugin_mtime/model/vo/movie_item_vo.dart';
import 'package:flutter_plugin_mtime/model/vo/movie_vo.dart';
import 'package:flutter_plugin_mtime/net/request.dart';
import 'package:flutter_plugin_mtime/ui/common_utils.dart';
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
  MovieVO _movie;

  @override
  void initState() {
    super.initState();
    _updatePaletteGenerator();
    _getMovieData();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: _colorBg,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Container(
              color: const Color(0x44000000),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildBar(),
              _builHead(),
              _buildRate(),
              _buildDetail(),
            ],
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
      backgroundColor: Colors.transparent,
    );
  }

  //上半部
  _builHead() {
    DateTime showTime = DateTime.parse(widget.movieItemVO.showTime);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Hero(
              tag: widget.movieItemVO.img,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                child: CachedNetworkImage(
                  imageUrl: CommonUtils.getImgMid(widget.movieItemVO.img),
                  fit: BoxFit.fitHeight,
                  height: 200,
                ),
              )),
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
                widget.movieItemVO.nameEn + '(' + widget.movieItemVO.year + ')',
                style: TextStyle(fontSize: 15),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.movieItemVO.during + '分钟',
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
                widget.movieItemVO.commonSpecial,
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
      margin: EdgeInsets.all(20.0),
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
                widget.movieItemVO.rate.toString(),
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Rating(
                widget.movieItemVO.rate,
                color: Colors.yellow,
              )
            ],
          ),
          SizedBox(
            height: 10,
          )
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
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
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
}
