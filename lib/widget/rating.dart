import 'package:flutter/material.dart';

class Rating extends StatefulWidget {
  final num rate;
  final Color color;
  final double size;

  const Rating(
    this.rate, {
    Key key,
    this.color,
    this.size,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RatingState();
  }
}

class RatingState extends State<Rating> {
  @override
  Widget build(BuildContext context) {
    return _buildStars();
  }

  _buildStars() {
    var stars = <Widget>[];
    for (int i = 1; i <= 5; i++) {
      stars.add(RatingStar(
        rate: widget.rate - i * 2,
        color: widget.color,
        size: widget.size,
      ));
    }
    return Row(
      children: stars,
    );
  }
}

class RatingStar extends StatefulWidget {
  final num rate;
  final Color color;
  final double size;

  const RatingStar({Key key, this.rate, this.color, this.size})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RatingStarState();
  }
}

class RatingStarState extends State<RatingStar> {
  @override
  Widget build(BuildContext context) {
    if (-1.5 <= widget.rate && widget.rate < 0) {
      return Icon(
        Icons.star_half,
        color: widget.color,
        size: widget.size,
      );
    } else if (widget.rate < 0) {
      return Icon(
        Icons.star_border,
        color: widget.color,
        size: widget.size,
      );
    } else {
      return Icon(
        Icons.star,
        color: widget.color,
        size: widget.size,
      );
    }
  }
}
