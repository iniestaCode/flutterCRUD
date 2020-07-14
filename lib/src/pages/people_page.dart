import 'dart:io';

import 'package:consultorio_crud/src/models/people_model.dart';
import 'package:consultorio_crud/src/providers/people_provider.dart';
import 'package:consultorio_crud/src/utils/utils.dart' as utils;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class PeoplePage extends StatefulWidget {
  
  @override
  _PeoplePageState createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
final formKey     = GlobalKey<FormState>();
final scaffoldKey = GlobalKey<ScaffoldState>();
PeopleModel  people = new PeopleModel();
final peopleProvider = new PeopleProvider();
bool guardando = false;
File foto;
  @override
  Widget build(BuildContext context) {
    final PeopleModel peopleData = ModalRoute.of(context).settings.arguments;
      if(peopleData!=null){
        people=peopleData;
      }      
    return Scaffold(      
      key: scaffoldKey,
      appBar: AppBar(   
        title:Text('People'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.photo_size_select_actual),
           onPressed: _seleccionarFoto,
                       ),
                       IconButton(icon: Icon(Icons.camera_alt),
                        onPressed: _tomarFoto,             
                       )],                   
                 ),                
                 body: SingleChildScrollView(
                   child: Container(                     
                     padding: EdgeInsets.all(15.0),
                     child: Form(
                       key: formKey,
                       child: Column(
                         children: <Widget>[
                           Text('Imagen de perfil',style: TextStyle(
                             fontSize: 20.0,
                             color: Colors.deepPurple,                             
                           ),),
                           _mostrarFoto(),
                           _crearNamePeople(),
                           SizedBox(height: 15.0,),
                           _crearAgePeople(),
                           SizedBox(height: 15.0,),                           
                           _crearBoton(),   
                          SizedBox(height: 50.0),                            
                          _loading(guardando) 
                                                                  
                         ],
                       ),
                     ),
                   ),
                 ),
               );
             }
           
            Widget _crearNamePeople() {
               return TextFormField(
                 initialValue: people.titulo,
                 textCapitalization: TextCapitalization.sentences,
                 decoration: InputDecoration(
                   labelText: 'Nombre',        
                 ),
                 onSaved: (value)=>people.titulo=value,                 
                 validator: (value){        
                     if(value.length<=0){
                       return 'Nombre invalido';
                     }else{
                       return null;
                     }
                 },
               );
           
             }
           
           Widget _crearAgePeople() {  
                 return TextFormField(
                 initialValue: people.valor.toString(),
                 keyboardType: TextInputType.numberWithOptions(decimal: true),
                 decoration: InputDecoration(
                   labelText: 'Edad',
                 ),
                 onSaved: (value)=>people.valor=int.parse(value),
                 validator: (value){
           
                   if(utils.isNumeric(value)){
                     return null;
                   }else{
                     return 'Solo numeros';
                   }
                 },
               );
           
             }
           
           Widget _crearBoton() {
             return RaisedButton.icon(
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(25.0),
               ),
               color: Colors.deepPurpleAccent,
               textColor: Colors.white,
               icon: Icon(Icons.save),
               label:Text('Guardar'),
               onPressed:(guardando) ? null : _submit,
               );
             }
           Widget _loading(bool ver){
             if(ver){
                return Image(
                image: AssetImage('assets/loading.gif'),                
                height: 100.0,
                width: 100.0,
                fit: BoxFit.cover,
              );
             }else{
               return Container();
             }
              
           }
             void _submit() async{
           
               if( !formKey.currentState.validate()) return;
           
               formKey.currentState.save();
               guardando=true;
                
               setState((){});
                if(foto != null){
                  people.fotoUrl=await peopleProvider.subirImagen(foto);
                }

               if(people.id==null){
                 peopleProvider.crearPeople(people);
                 _mostrarSnackBar('Se agregò a la persona');
               }else{
                 peopleProvider.editarPeople(people);
                 _mostrarSnackBar('Se actualizò la persona');
               }
               
               guardando=false;
           
               setState((){});
               Navigator.pushNamed(context, 'home');
             }
           void _mostrarSnackBar(String mensaje){
             final snack=SnackBar(
               content: Text(mensaje),
               duration: Duration(milliseconds: 5000),    
             );
             scaffoldKey.currentState.showSnackBar(snack);
           }         
           

Widget _mostrarFoto(){
  if(people.fotoUrl != null){

    return FadeInImage(
      image: NetworkImage(people.fotoUrl),
      placeholder: AssetImage('assets/jar-loading.gif'),
      height: 300.0,
      fit: BoxFit.contain,
    );
  }else{
    return Image(
      image: AssetImage(foto?.path ?? 'assets/no-image.png'),
      height: 300.0,
      fit: BoxFit.cover,
    );
  }
}           
void _seleccionarFoto() async{

  _procesarImagen(ImageSource.gallery);
  }

  void _tomarFoto() async{

  _procesarImagen(ImageSource.camera);
  }

  void _procesarImagen (ImageSource origen) async{
    foto=await ImagePicker.pickImage(
    source: origen,
    );
    if(foto!=null){
      people.fotoUrl=null;
    }
    setState((){});
  }
}