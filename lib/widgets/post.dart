import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/constants/common_size.dart';
import 'package:flutter_project/constants/screen_size.dart';
import 'package:flutter_project/repo/image_network_repository.dart';
import 'package:flutter_project/widgets/my_progress_indicator.dart';
import 'package:flutter_project/widgets/rounded_avatar.dart';
import 'comment.dart';
import '';

class Post extends StatelessWidget {
  final int index;

  Post(this.index, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _postHeader(),
        _postImage(),
        _postActions(),
        _postLikes(),
        _postCaption(),
      ],
    );
  }

  Widget _postCaption() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap, vertical: common_xxs_gap),
      child: Comment(showImage: false,
      username: 'testingUser',
        text: 'I have money',
      )
    );
  }

  Padding _postLikes() {
    return Padding(
      padding: const EdgeInsets.only(left: common_gap),
      child: Text(
        '12000 likes',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Row _postActions() {
    return Row(
      children: [
        IconButton(
          icon: ImageIcon(AssetImage('assets/images/bookmark.png')),
          color: Colors.black87,
          onPressed: null,
        ),
        IconButton(
          icon: ImageIcon(AssetImage('assets/images/comment.png')),
          color: Colors.black87,
          onPressed: null,
        ),
        IconButton(
          icon: ImageIcon(AssetImage('assets/images/direct_message.png')),
          color: Colors.black87,
          onPressed: null,
        ),
        Spacer(),
        IconButton(
          icon: ImageIcon(AssetImage('assets/images/heart_selected.png')),
          color: Colors.black87,
          onPressed: null,
        )
      ],
    );
  }

  Widget _postHeader() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(common_xxs_gap),
          child: RoundedAvatar(),
        ),
        Expanded(child: Text('UserName')),
        IconButton(
          onPressed: null,
          icon: Icon(
            Icons.more_horiz,
            color: Colors.black87,
          ),
        )
      ],
    );
  }

  Widget _postImage() {
    Widget progress = MyProgressIndicator(
      containerSize: size.width,
    );
    return FutureBuilder<dynamic>(
      future: imageNetworkRepository.getPostImageUrl("gs://instagram-413bd.appspot.com/김종성6.jpg"),
      builder: (context, snapshot) {
        if(snapshot.hasData)
        return CachedNetworkImage(
          imageUrl: 'https://picsum.photos/id/$index/200/200',
          placeholder: (BuildContext context, String url) {
            return progress;
          },
          imageBuilder: (BuildContext context, ImageProvider imageProvider) {
            return AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                    image:
                    DecorationImage(image: imageProvider, fit: BoxFit.cover)),
              ),
            );
          },
        );
        else
          return progress;
      }
    );
  }
}

