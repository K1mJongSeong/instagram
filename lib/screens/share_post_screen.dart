import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/constants/common_size.dart';
import 'package:flutter_project/constants/screen_size.dart';
import 'package:flutter_project/repo/image_network_repository.dart';
import 'package:flutter_project/widgets/my_progress_indicator.dart';
import 'package:flutter_tags/flutter_tags.dart';

class SharePostScreen extends StatelessWidget {
  final File imageFile;
  final String postKey;

  SharePostScreen(this.imageFile, {Key key, @required this.postKey})
      : super(key: key);

  bool checked = false;

  List<String> _tagItems = [
    "approval",
    "pigeon",
    "brown",
    "expenditure",
    "compromise",
    "citizen",
    "inspire",
    "relieve",
    "grave",
    "incredible",
    "invasion",
    "voucher",
    "girl",
    "relax",
    "problem",
    "queue",
    "aviation",
    "profile",
    "palace",
    "drive",
    "money",
    "revolutionary",
    "string",
    "detective",
    "follow",
    "text",
    "bet",
    "decade",
    "means",
    "gossip"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('New Post is good'),
          actions: [
            FlatButton(
                onPressed: () async {
                  showModalBottomSheet(
                      context: context,
                      builder: (_) => MyProgressIndicator(),
                      isDismissible: false,
                      enableDrag: false);
                 await imageNetworkRepository.uploadImageNCreateNewPost(imageFile,postKey: postKey);
                 Navigator.of(context).pop();
                },
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
            _tags(),
            SizedBox(
              height: common_s_gap,
            ),
            _divider,
            SectionSwitch('Facebook'),
            SectionSwitch('Instagram'),
            SectionSwitch('Tumblr'),
            _divider
          ],
        ));
  }

  Tags _tags() {
    return Tags(
        horizontalScroll: true,
        itemCount: _tagItems.length,
        heightHorizontalScroll: 30,
        itemBuilder: (index) => ItemTags(
              index: index,
              title: _tagItems[index],
              activeColor: Colors.grey[200],
              textActiveColor: Colors.black87,
              borderRadius: BorderRadius.circular(4),
              elevation: 2,
              splashColor: Colors.grey[800],
              highlightColor: Colors.red,
              color: Colors.red,
            ));
  }

  Divider get _divider => Divider(
        color: Colors.grey[300],
        thickness: 1,
        height: 1,
      );

  ListTile _sectionButton(String title) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w400),
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

class SectionSwitch extends StatefulWidget {
  final String _title;

  const SectionSwitch(
    this._title, {
    Key key,
    @required this.checked,
  }) : super(key: key);

  final bool checked;

  @override
  _SectionSwitchState createState() => _SectionSwitchState();
}

class _SectionSwitchState extends State<SectionSwitch> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget._title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: CupertinoSwitch(
        value: widget.checked,
        onChanged: (onValue) {
          setState(() {
            checked = onValue;
          });
        },
      ),
      dense: true,
      contentPadding: EdgeInsets.symmetric(
        horizontal: common_gap,
      ),
    );
  }
}
