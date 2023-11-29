import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socar/models/user.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Firestore에 User 객체를 저장하는 메서드
  Future<void> save(User user) async {
    await _firestore.collection('users').doc(user.uid).set({
      'uid': user.uid,
      'email': user.email,
      'phoneNumber': user.phoneNumber,
      'username': user.username
    });
  }

  // uid를 사용하여 Firestore에서 User 객체를 검색하는 메서드
  Future<User?> findByUid(String uid) async {
    var document = await _firestore.collection('users').doc(uid).get();

    if (!document.exists) {
      return null;
    }

    var data = document.data();
    return User(
      uid: data?['uid'] ?? '',
      email: data?['email'] ?? '',
      phoneNumber: data?['phoneNumber'] ?? '',
      username: data?['username'] ?? '',
    );
  }

  Future<DocumentReference?> getDocRefByUid(String? uid) async {
    return _firestore.collection('users').doc(uid);
  }
}
