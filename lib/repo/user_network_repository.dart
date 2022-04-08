import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/constants/firestore_keys.dart';

class UserNetworkRepository {
  Future<void> attemptCreateUser({String userKey, String email}) async {
    final DocumentReference userRef=Firestore.instance.collection(COLLECTION_USERS).document(userKey);
  }
}

UserNetworkRepository userNetworkRepository = UserNetworkRepository();