import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'config.dart';

final FirebaseAuth _auth=FirebaseAuth.instance;

Future<FirebaseUser> signIn(String provider) async{
  FirebaseUser user;
  if (provider==valsConfig.TAG_GOOGLE){
    final GoogleSignIn googleSignIn=GoogleSignIn();
    final GoogleSignInAccount googleSignInAccount=await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication=await googleSignInAccount.authentication;

    final AuthCredential credential=GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken
    );

    user=(await _auth.signInWithCredential(credential)).user;
  }
  else{
    //Login con Twitter
    if (provider==valsConfig.TAG_TWITTER){
      final TwitterLogin twitterLogin=TwitterLogin(
          consumerKey: valsConfig.TWITTER_API_KEY,
          consumerSecret: valsConfig.TWITTER_API_SECRET
      );
      var twitterResult= await twitterLogin.authorize();
      if (twitterResult.status!=TwitterLoginStatus.loggedIn)
        return null;
      var session = twitterResult.session;
      final AuthCredential credential = TwitterAuthProvider.getCredential(
          authToken: session.token, authTokenSecret: session.secret);

      user=(await _auth.signInWithCredential(credential)).user;
    }
    else{
      if (provider==valsConfig.TAG_FACEBOOK){
        return null;
      }
    }
  }
  return user;
}
void signOut(String proveedor) async{
  if (proveedor==valsConfig.TAG_GOOGLE)
    await GoogleSignIn().signOut();
  if (proveedor==valsConfig.TAG_TWITTER)
    await TwitterLogin(
        consumerKey: valsConfig.TWITTER_API_KEY,
        consumerSecret: valsConfig.TWITTER_API_SECRET
    ).logOut();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.remove(valsConfig.TAG_PREFS_PROVEEDOR_LOGIN);
  sharedPreferences.remove(valsConfig.TAG_PREFS_NOMBRE_USUARIO);
  sharedPreferences.remove(valsConfig.TAG_PREFS_UID_USUARIO);
  sharedPreferences.remove(valsConfig.TAG_PREFS_EMAIL_USUARIO);
  sharedPreferences.remove(valsConfig.TAG_PREFS_PHOTO_URL);
  //print("Desconexión correcta");
}