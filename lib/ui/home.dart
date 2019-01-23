import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_base/utils/log_utils.dart';
import 'package:flutter_plugin_mtime/constant/colors.dart';
import 'package:flutter_plugin_mtime/model/vo/movie_item_vo.dart';
import 'package:flutter_plugin_mtime/net/request.dart';
import 'package:flutter_plugin_mtime/ui/common_utils.dart';
import 'package:flutter_plugin_mtime/ui/movie_detail.dart';
import 'package:flutter_plugin_mtime/widget/tag.dart';
import 'package:flutter_plugin_base/constant/pagestatus.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<HomePage> {
  PageStatus hotStatus = PageStatus.LOADING;
  List<MovieItemVO> _hotMovies;
  PageStatus comingStatus = PageStatus.LOADING;
  List<MovieItemVO> _comingMovies;

  @override
  void initState() {
    super.initState();
    _getHotMoviesData();
    _getComingMoviesData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Mcolors.contentBackground,
        title: Container(
          padding: EdgeInsets.all(3.0),
          child: Text(
            'MTime',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          decoration: BoxDecoration(
              border: Border.all(width: 2.0, color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(3.0))),
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(icon: Icon(Icons.account_circle), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            _buildHot(),
            SizedBox(
              height: 30.0,
            ),
            _buildComing(),
//          Chewie(
//             VideoPlayerController.network(
//                'http://vfx.mtime.cn/Video/2018/12/28/mp4/181228150811700206.mp4'
//            ),
//            aspectRatio: 3 / 2,
//            autoPlay: true,
//            looping: true,
//          )
          ],
        ),
      ),
    );
  }

  _getHotMoviesData() async {
    Request().getHotMovies().then((List<MovieItemVO> movies) {
      _hotMovies = movies;
      setState(() {
        hotStatus = _hotMovies.length == 0 ? PageStatus.EMPTY : PageStatus.DATA;
      });
    }).catchError((error) {
      Log.i(error.toString());
      setState(() {
        hotStatus = PageStatus.ERROR;
      });
    });
  }

  _getComingMoviesData() async {
    Request().getComingMovies().then((List<MovieItemVO> movies) {
      _comingMovies = movies;
      setState(() {
        comingStatus =
            _comingMovies.length == 0 ? PageStatus.EMPTY : PageStatus.DATA;
      });
    }).catchError((error) {
      Log.i(error.toString());
      setState(() {
        comingStatus = PageStatus.ERROR;
      });
    });
  }

  //正在热映
  _buildHot() {
    switch (hotStatus) {
      case PageStatus.DATA:
        return Container(
          color: Mcolors.contentBackground,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
                child: Text(
                  '正在热映',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Container(
                height: 300,
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return _buildHotMovieCard(index);
                  },
                  itemCount: _hotMovies == null ? 0 : _hotMovies.length,
                  scrollDirection: Axis.horizontal,
                ),
              )
            ],
          ),
        );
        break;
      case PageStatus.LOADING:
      case PageStatus.EMPTY:
      case PageStatus.ERROR:
        return SizedBox();
        break;
    }
  }

  //热门
  _buildHotMovieCard(index) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MoviePage(_hotMovies[index])));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        width: 150,
        child: Column(
          children: <Widget>[
            Hero(
                tag: _hotMovies[index].img + _hotMovies[index].t.toString(),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: CachedNetworkImage(
                    imageUrl: CommonUtils.getImgMid(_hotMovies[index].img),
                    fit: BoxFit.fitHeight,
                    height: 200,
                  ),
                )),
            SizedBox(
              height: 10.0,
            ),
            Center(
              child: Text(
                _hotMovies[index].name,
                style: TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                Text(_hotMovies[index].rate > 0
                    ? _hotMovies[index].rate.toString() + '/10'
                    : '--/10')
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            _hotMovies[index].versions == null
                ? SizedBox()
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: _hotMovies[index]
                        .versions
                        .map((version) => Tag(version))
                        .toList(),
                  ),
          ],
        ),
      ),
    );
  }

  //即将上映
  _buildComing() {
    switch (comingStatus) {
      case PageStatus.DATA:
        return Container(
          color: Mcolors.contentBackground,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
                child: Text(
                  '即将上映',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Container(
                height: 300,
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return _buildComingMovieCard(index);
                  },
                  itemCount: _comingMovies == null ? 0 : _comingMovies.length,
                  scrollDirection: Axis.horizontal,
                ),
              )
            ],
          ),
        );
        break;
      case PageStatus.LOADING:
      case PageStatus.EMPTY:
      case PageStatus.ERROR:
        return SizedBox();
        break;
    }
  }

  //即将上映
  _buildComingMovieCard(index) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MoviePage(_comingMovies[index])));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        width: 150,
        child: Column(
          children: <Widget>[
            Hero(
                tag: _comingMovies[index].img +
                    _comingMovies[index].t.toString(),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: CachedNetworkImage(
                    imageUrl: CommonUtils.getImgMid(_comingMovies[index].img),
                    fit: BoxFit.fitHeight,
                    height: 200,
                  ),
                )),
            SizedBox(
              height: 10.0,
            ),
            Center(
              child: Text(
                _comingMovies[index].name,
                style: TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(_comingMovies[index].showTimeStr == null
                ? ''
                : _comingMovies[index].showTimeStr),
            SizedBox(
              height: 5.0,
            ),
            Text(_comingMovies[index].type == null
                ? ''
                : _comingMovies[index].type),
          ],
        ),
      ),
    );
  }
}
