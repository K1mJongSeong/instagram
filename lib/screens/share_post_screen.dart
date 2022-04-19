import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project/constants/common_size.dart';
import 'package:flutter_project/constants/screen_size.dart';

class SharePostScreen extends StatelessWidget {
  final File imageFile;
  final String postKey;

  const SharePostScreen(this.imageFile, {Key key, @required this.postKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('New Post'),
          actions: [
            FlatButton(
                onPressed: () {},
                child: Text(
                  "Share",
                  textScaleFactor: 1.4,
                  style: TextStyle(color: Colors.blue),
                ))
          ],
        ),
        body: ListView(
          children: [
            _captionWithImage(),
            _divider,
            _sectionButton('Tag People'),
            _divider,
            _sectionButton('Add location'),
          ],
        ));
  }

  Divider get _divider => Divider(
            color: Colors.grey[300],
            thickness: 1,
            height: 100,
          );


  ListTile _sectionButton(String title) {
    return ListTile(
            title: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Icon(Icons.navigate_next),
            dense: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: common_gap,
            ),
          );
  }

  ListTile _captionWithImage() {
    return ListTile(
      contentPadding:
          EdgeInsets.symmetric(vertical: common_gap, horizontal: common_gap),
      leading: Image.file(
        imageFile,
        width: size.width / 6,
        height: size.height / 6,
        fit: BoxFit.cover,
      ),
      title: TextField(
        decoration: InputDecoration(
            hintText: 'Write a caption..', border: InputBorder.none),
      ),
    );
  }
}
