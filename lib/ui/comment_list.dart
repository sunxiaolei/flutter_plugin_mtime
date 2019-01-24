import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_base/constant/pagestatus.dart';
import 'package:flutter_plugin_base/utils/log_utils.dart';
import 'package:flutter_plugin_base/widget/pullrefresh/pullrefresh.dart';
import 'package:flutter_plugin_mtime/model/vo/comment_item_vo.dart';
import 'package:flutter_plugin_mtime/net/api.dart';
import 'package:flutter_plugin_mtime/net/request.dart';
import 'package:flutter_plugin_mtime/ui/web.dart';
import 'package:flutter_plugin_mtime/widget/rating.dart';

class CommentList extends StatefulWidget {
  final int movieId;
  final String movieName;
  final bool isLongComment;

  const CommentList(
    this.movieId,
    this.movieName,
    this.isLongComment, {
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CommentListState();
  }
}

class CommentListState extends State<CommentList> {
  PageStatus listStatus = PageStatus.LOADING;
  List<CommentItemVO> listComment;

  int _index = 1;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  _refresh() {
    _index = 1;
    if (widget.isLongComment) {
      Request().getMovieLongComment(_index, widget.movieId).then((list) {
        listComment = list;
        setState(() {
          listStatus =
              listComment.length == 0 ? PageStatus.EMPTY : PageStatus.DATA;
        });
      }).catchError((error) {
        listStatus = PageStatus.ERROR;
      });
    } else {
      Request().getMovieShortComment(_index, widget.movieId).then((list) {
        listComment = list;
        setState(() {
          listStatus =
              listComment.length == 0 ? PageStatus.EMPTY : PageStatus.DATA;
        });
      }).catchError((error) {
        listStatus = PageStatus.ERROR;
      });
    }
  }

  _loadmore() {
    if (widget.isLongComment) {
      Request().getMovieLongComment(_index, widget.movieId).then((list) {
        listComment.addAll(list);
        setState(() {
          listStatus = PageStatus.DATA;
        });
      }).catchError((error) {
        Log.i(error.message);
      });
    } else {
      Request().getMovieShortComment(_index, widget.movieId).then((list) {
        listComment.addAll(list);
        setState(() {
          listStatus = PageStatus.DATA;
        });
      }).catchError((error) {
        Log.i(error.message);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movieName),
      ),
      body: _buildList(),
    );
  }

  _buildList() {
    switch (listStatus) {
      case PageStatus.DATA:
        if (widget.isLongComment) {
          return PullRefresh(
            onRefresh: _refresh,
            onLoadmore: _loadmore,
            scrollView: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return _buildLongComment(listComment[index]);
              },
              itemCount: listComment.length,
              shrinkWrap: true,
            ),
          );
        } else {
          return PullRefresh(
            onRefresh: _refresh,
            onLoadmore: _loadmore,
            scrollView: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return _buildShortComment(listComment[index]);
              },
              itemCount: listComment.length,
              shrinkWrap: true,
            ),
          );
        }
        break;
      case PageStatus.LOADING:
        return Center(
          child: CircularProgressIndicator(),
        );
        break;
      case PageStatus.ERROR:
        return Center(
          child: Text(
            'ERROR',
            style: TextStyle(fontSize: 22),
          ),
        );
        break;
      case PageStatus.EMPTY:
      default:
        return Center(
          child: Text(
            'EMPTY',
            style: TextStyle(fontSize: 22),
          ),
        );
        break;
    }
  }

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
            maxLines: 2,
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
                              widget.movieId, comment.commentId))));
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
}
