import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/constants/firestore_keys.dart';

class UserModel {
  final String userKey;
  final String profileImg;
  final String email;
  final List<dynamic> myPosts;
  final int followers;
  final List<dynamic> likePosts;
  final String userName;
  final List<dynamic> followings;
  final DocumentReference reference;

  UserModel.fromMap(Map<String, dynamic> map, this.userKey,
      {this.reference})
      : profileImg = map[KEY_PROFILEIMG],
        userName = map[KEY_USERNAME],
        email = map[KEY_EMAIL],
        likePosts = map[KEY_LIKEDPOSTS],
        followers = map[KEY_FOLLOWERS],
        followings = map[KEY_FOLLOWINGS],
        myPosts = map[KEY_MYPOSTS];

  UserModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, snapshot.documentID,
            reference: snapshot.reference);
}
