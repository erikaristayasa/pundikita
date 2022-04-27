import 'package:google_sign_in/google_sign_in.dart';

import 'helper.dart';

class GoogleSignInHelper {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  Future<GoogleSignInAccount?> signIn() async {
    try {
      return await _googleSignIn.signIn();
    } catch (e) {
      logMe(e);
      return null;
    }
  }

  Future<bool> signOut() async {
    try {
      final _user = await _googleSignIn.signOut();
      if (_user == null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      logMe(e);
      return false;
    }
  }

  Future<GoogleSignInAccount?> getCurrentUser() async {
    final _currentUser = _googleSignIn.currentUser;
    if (_currentUser != null) {
      logMe(_currentUser);
    }
    return _currentUser;
  }
}
