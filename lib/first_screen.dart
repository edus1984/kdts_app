import 'package:flutter/material.dart';
import 'package:flutterapp/login_page.dart';
import 'package:flutterapp/sign_in.dart';
import 'config.dart';

class FirstScreen extends StatelessWidget{
  final String name;
  final String email;
  final String imageUrl;
  final String proveedor;
  FirstScreen({Key key,this.proveedor,this.name,this.email,this.imageUrl}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue[100],Colors.blue[400]]
          )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(imageUrl),
                radius: 60,
                backgroundColor: Colors.transparent,
              ),
              SizedBox(height: 40),
              Text(
                'Nombre',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54
                ),
              ),
              Text(
                name,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 20),
              Text(
                'E-mail',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54
                ),
              ),
              Text(
                email,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  color: Colors.deepPurple
                ),
              ),
              SizedBox(height: 40),
              RaisedButton(
                onPressed: (){
                  signOut(proveedor);
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context){return LoginPage();}),
                      ModalRoute.withName('/')
                  );
                },
                color: Colors.deepPurple,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Cerrar sesión',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white
                    )
                  ),
                ),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}