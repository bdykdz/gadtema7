import 'package:firebase_auth/firebase_auth.dart';

import '../models/index.dart';

class AuthApi {
  AuthApi(this._auth);

  final FirebaseAuth _auth;

  Future<AppUser?> checkUser() async {
    final User? user = _auth.currentUser;
    if (user == null) {
      return null;
    }
    return AppUser(id: user.uid, userName: user.displayName ?? user.email!.split('@').first, email: user.email!);
  }

  Future<AppUser> createUser({required String email, required String password}) async {
    final UserCredential credentials = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    final User user = credentials.user!;
    return AppUser(
      id: user.uid,
      userName: email.split('@').first,
      email: email,
    );
  }

  Future<AppUser> loginUser({required String email, required String password}) async {
    final UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    final User user = credential.user!;
    return AppUser(
        id: user.uid, userName: user.displayName ?? email.split('@').first, email: email, profileImages: user.photoURL);
  }

  Future<void> logOut() async {
    await _auth.signOut();
  }
}
