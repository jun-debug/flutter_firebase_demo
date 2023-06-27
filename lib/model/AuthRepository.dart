import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  FirebaseAuth firebaseAuth;
  Stream<User?> get authState => firebaseAuth.idTokenChanges();
  AuthRepository() : firebaseAuth = FirebaseAuth.instance;

  Future<String> signUp({required String email, required String password}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Success";
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return e.message== null ? "Unknown error in signup" : e.message!;
    }
  }

  Future<bool> signIn({required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return false;
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}