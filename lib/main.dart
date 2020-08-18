import 'package:flutter/material.dart';
import 'config.dart';
import 'login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KDT',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: LoginPage(),
      home: MyHomePage(title: 'KDT App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  initState() {

    super.initState();

    getCredential();
  }
  dispose() {
    // Es importante SIEMPRE realizar el dispose del controller.
    super.dispose();
  }
  getCredential() async {

    SharedPreferences.setMockInitialValues({});
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String _uid = sharedPreferences.getString(valsConfig.TAG_PREFS_UID_USUARIO);
    if(_uid!=null){
      /*Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Ppal(usuario:_correo,idCliente:_idCliente)),
      );*/
    }else{
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      /*body:Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/fondo.png'),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Positioned(
              top: 0,
              left: 10.0,
              right: 10.0,
              child: Image.asset('assets/user.png')
          ),
          Material(color: Colors.yellowAccent),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.*/
    );
  }
}