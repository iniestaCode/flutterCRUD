


import 'dart:async';

class Validators{


  final validarEmail=StreamTransformer<String,String>.fromHandlers(
    handleData: (email,sink){
     Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp redExp = new RegExp(pattern);
      if(redExp.hasMatch(email)){
        sink.add(email);
      }else{
        sink.addError('Direcciòn de correo no valida');
      }
    }
  );

  final validarPassword=StreamTransformer<String,String>.fromHandlers(
    handleData: (password,sink){
      if(password.length>=6){
          sink.add(password);
      }else{
        sink.addError('Deben ser màs de 6 caracteres');
      }
    }
  );

}