import 'package:consultorio_crud/src/bloc/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _loginForm(context),
        ],
      ),
        
    );
  }

 Widget _crearFondo(BuildContext context) {
   final size=MediaQuery.of(context).size;
   final fondoMorado= Container(
     height: size.height*0.4,
     width: double.infinity,
     decoration: BoxDecoration(
       gradient: LinearGradient(
         colors: <Color>[
           Color.fromRGBO(63, 63, 156, 1.0),
           Color.fromRGBO(90, 70, 178, 1.0),
         ]
         )
     ),
   );

final circulo=Container(
  height: 100.0,
  width: 100.0,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(100.0),
    color: Color.fromRGBO(255, 255, 255, 0.07)
  ),
);

final _informacion=Container(
  padding: EdgeInsets.only(top:70.0),
      child:Column(        
        children: <Widget>[       
          Icon(Icons.person_pin_circle,size: 120.0,color:Colors.white60),          
          SizedBox(height: 10.0,width: double.infinity,),
          Text('Login',style: TextStyle(
            color:Colors.white70,
            fontSize: 25.0,      
          ),)
        ],
      )
   );


   return Stack(
     children: <Widget>[      
       fondoMorado,
       Positioned(top: -30.0,left: 355.0,child: circulo,),
       Positioned(top: 10.0,left: 75.0,child: circulo,),
       Positioned(top: 200.0,left: 155.0,child: circulo,),
       Positioned(top: 250.0,right:350.0,child: circulo,),
       _informacion,
     ],
   );
 }


Widget  _loginForm(BuildContext context) {
  final bloc = Provider.of(context);
  final size = MediaQuery.of(context).size;


  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        SafeArea(child: Container(height: 225.0,)),
        Container(
          width: size.width*0.85,
          padding: EdgeInsets.symmetric(vertical:50.0),
          margin:EdgeInsets.symmetric(vertical:50.0),          
          decoration: BoxDecoration(
            color:Colors.white,
            borderRadius: BorderRadius.circular(6.0),
            boxShadow: <BoxShadow>[
            BoxShadow(
                color:Colors.black26,
                blurRadius: 5.0,
                offset: Offset(0.0,5.5),
                spreadRadius: 3.0
            )
            ]
          ),
          child: Column(
            children: <Widget>[
              Text('Ingreso',style: TextStyle(fontSize: 20.0)),
              _crearEmail(bloc),    
              _crearPassword(bloc),
              SizedBox(height: 30.0,),
              _crearBoton(bloc),
            ],
          ),
        ),
        Text('¿Olvidòsu contraseña?'),
        SizedBox(height: 100.0,)
      ], 
      
    ),
  );
  }

Widget _crearEmail(LoginBloc bloc) {

  return StreamBuilder(
    stream:bloc.emailStream,
      builder: (BuildContext context,AsyncSnapshot snapshot){
              return Container(
          padding: EdgeInsets.symmetric(horizontal:15.0),
          margin:EdgeInsets.only(top:50.0),

          child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                icon: Icon(Icons.alternate_email,color: Colors.deepPurpleAccent),
                hintText: 'ejemplo@email.com',
                labelText: 'Correo Electronico',
                errorText: snapshot.error,
                counterText: snapshot.data,
              ),
              onChanged: (value)=>bloc.changeEmail(value),
          ),
        );
      }
    
    );



  }

Widget _crearPassword(LoginBloc bloc) {


  return StreamBuilder(
    stream: bloc.passwordStream,
    builder: (BuildContext context, AsyncSnapshot snapshot){
      return Container(
        padding: EdgeInsets.symmetric(horizontal:15.0),
        margin:EdgeInsets.only(top:50.0),

        child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock_open,color: Colors.deepPurpleAccent),              
              labelText: 'Password',
              counterText: snapshot.data,
              errorText: snapshot.error,               
            ),
            onChanged: bloc.changePassword,
        ),
      );
    },

  );
      
  }
Widget _crearBoton(LoginBloc bloc){

  return StreamBuilder(
    stream: bloc.formValidStream,

    builder: (BuildContext context, AsyncSnapshot snapshot){
      return RaisedButton(
    child:Container(
      padding: EdgeInsets.symmetric(horizontal: 80.0,vertical: 10.0),
        child:Text('Ingresar'),
    ), 
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6.0),
    ),
    elevation: 0.1,
    color:Colors.deepPurpleAccent,
    textColor: Colors.white,
    
    onPressed: snapshot.hasData ? () =>_login(bloc,context): null
    );
    },);

  ;
}

_login(LoginBloc bloc, BuildContext context){
print("=========================");
print('correo ${bloc.email}');
print('password ${bloc.password}');
print("=========================");
Navigator.pushReplacementNamed(context,'home');
}
}