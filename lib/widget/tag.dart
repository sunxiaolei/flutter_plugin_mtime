import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  final String text;
  final double textSize;
  final Color textColor;
  final Color borderColor;
  final double padding;
  final double borderRadius;
  final double marginHorizontal;
  final double marginvertical;

  const Tag(this.text,
      {Key key,
      this.textSize: 9,
      this.textColor: Colors.white70,
      this.borderColor: Colors.white70,
      this.padding: 1.0,
      this.borderRadius: 2.0,
      this.marginHorizontal: 2.0,
      this.marginvertical: 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      margin: EdgeInsets.symmetric(
          horizontal: marginHorizontal, vertical: marginvertical),
      child: Text(
        text,
        style: TextStyle(fontSize: textSize, color: textColor),
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      ),
    );
  }
}
