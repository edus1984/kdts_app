import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'first_screen.dart';
import 'config.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(image: AssetImage(valsConfig.LOGO_KDT),height: 35.0),
              SizedBox(height: 50),
              _signInButton(valsConfig.TAG_GOOGLE,valsConfig.LOGO_GOOGLE,valsConfig.TAG_GOOGLE),
              _signInButton(valsConfig.TAG_TWITTER,valsConfig.LOGO_TWITTER,valsConfig.TAG_TWITTER),
              _signInButton(valsConfig.TAG_FACEBOOK,valsConfig.LOGO_FACEBOOK,valsConfig.TAG_FACEBOOK),
            ],
          ),
        )
      )
    );
  }

  Widget _signInButton(String nombre,String logo, String proveedorLogueo){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: OutlineButton(
        splashColor: Colors.grey,
        onPressed: () => login(proveedorLogueo),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        highlightElevation: 0,
        borderSide: BorderSide(color: Colors.grey),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(image: AssetImage(logo),height: 35.0),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Ingresar con '+nombre,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //Login con todos los proveedores
  void login(String proveedor) async{
    FirebaseUser user=await signIn(proveedor);
    if (user!=null && user.uid.isNotEmpty){
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString(valsConfig.TAG_PREFS_NOMBRE_USUARIO, user.displayName);
      sharedPreferences.setString(valsConfig.TAG_PREFS_UID_USUARIO, user.uid);
      if (user.email.isNotEmpty) sharedPreferences.setString(valsConfig.TAG_PREFS_EMAIL_USUARIO, user.email);
      if (user.photoUrl.isNotEmpty) sharedPreferences.setString(valsConfig.TAG_PREFS_PHOTO_URL, user.photoUrl);
      sharedPreferences.setString(valsConfig.TAG_PREFS_PROVEEDOR_LOGIN, proveedor);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => FirstScreen(proveedor: proveedor,name: user.displayName,email: user.email,imageUrl: user.photoUrl)
          )
      );
    }
  }

}