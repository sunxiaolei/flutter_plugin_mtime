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

  @override
  void initState() {
    super.initState();
    _getHotMoviesData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            //状态栏高度
            height: MediaQueryData.fromWindow(window).padding.top,
          ),
          _buildAppBar(),
          SizedBox(
            height: 20.0,
          ),
          _buildHot(),
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

  //标题栏
  _buildAppBar() {
    return Container(
      color: Mcolors.contentBackground,
      height: 56.0,
      padding: EdgeInsets.only(left: 18.0),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(3.0),
            child: Text(
              'MTime',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            decoration: BoxDecoration(
                border: Border.all(width: 2.0, color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(3.0))),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(Icons.search),
            ),
          ),
          Container(
            child:
                IconButton(icon: Icon(Icons.account_circle), onPressed: () {}),
          )
        ],
      ),
    );
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
                tag: _hotMovies[index].img,
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
}
