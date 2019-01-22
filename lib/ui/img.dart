import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImagePage extends StatelessWidget {
  final String imgUrl;

  const ImagePage(
    this.imgUrl, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Image'),
      ),
      body: Center(
        child: Hero(
            tag: imgUrl,
            child: CachedNetworkImage(
              imageUrl: imgUrl,
              placeholder: Center(
                child: CircularProgressIndicator(),
              ),
            )),
      ),
    );
  }
}
