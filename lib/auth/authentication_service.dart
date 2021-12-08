import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String> signIn(String email, String password) async {

    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return 'Signed in';
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  Future<String> signUp(
      String email, String firstName, String lastName, String password) async {

    var data = {
        'frequence' : 70,
        'humidity': 19,
        'temperature': 38,
        'time': "11:11:11"
    };

    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      CollectionReference users = FirebaseFirestore.instance.collection('users');
      FirebaseAuth auth = FirebaseAuth.instance;
      String uid = auth.currentUser!.uid.toString();
      users.doc(uid).set({'29112021' : [data], 'firstname': firstName, 'lastname': lastName});
      return 'Registered';
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }
}
