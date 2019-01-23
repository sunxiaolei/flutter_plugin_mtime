import 'package:flutter_plugin_mtime/model/vo/comment_item_vo.dart';

class HotCommentVO {
  List<CommentItemVO> listShort;
  List<CommentItemVO> listLong;

  HotCommentVO(this.listShort, this.listLong);
}
