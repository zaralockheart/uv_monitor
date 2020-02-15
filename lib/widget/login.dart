import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uv_assessment/generated/l10n.dart';
import 'package:uv_assessment/res/color.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'home.dart';

/// Refer https://www.figma.com/file/TbdGiIl24TvsNqV3lIK9Dg/Assignment---Flutter?node-id=1%3A2
/// for design.
class Login extends HookWidget {
  final _googleSignIn = GoogleSignIn();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final _locale = S.of(context);

    final _textTheme = Theme.of(context).textTheme;

    void _navigateToHome() => Home.push(context);

    Future<void> _handleGoogleSignIn() async {
      try {
        final GoogleSignInAccount googleSignInAccount =
            await _googleSignIn.signIn();
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.getCredential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final AuthResult authResult =
            await _auth.signInWithCredential(credential);
        final FirebaseUser user = authResult.user;

        assert(!user.isAnonymous);
        assert(await user.getIdToken() != null);

        final FirebaseUser currentUser = await _auth.currentUser();

        if (user.uid == currentUser.uid) {
          _navigateToHome();
        }
      } catch (_) {}
    }

    Future<void> _autoSignIn() async {
      try {
        final signInAccount =
            await _googleSignIn.signInSilently(suppressErrors: false);

        if (signInAccount != null) {
          _navigateToHome();
        }
      } catch (_) {}
    }

    useEffect(() {
      _autoSignIn();
      return null;
    }, [false]);

    return Scaffold(
      key: const Key('login'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/sun.png'),
            Padding(
              padding: const EdgeInsets.only(top: 29.0, bottom: 51),
              child: Text(
                S.of(context).appTitle,
                textAlign: TextAlign.center,
                style: _textTheme.headline3.copyWith(
                  fontSize: 36,
                  color: orange,
                ),
              ),
            ),
            MaterialButton(
              key: const Key('sign in button'),
              color: blueGoogle,
              onPressed: _handleGoogleSignIn,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Image.asset('assets/google.png'),
                  ),
                  Text(
                    _locale.signInGoogle,
                    style: _textTheme.button.copyWith(
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
