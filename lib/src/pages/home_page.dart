import 'package:consultorio_crud/src/models/people_model.dart';
import 'package:consultorio_crud/src/providers/people_provider.dart';
import 'package:flutter/material.dart';
class HomePage extends StatelessWidget {
  final peopleProvider = new PeopleProvider();
  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page - Personas'),
        )
        ,body: _crearListado(),
        floatingActionButton: _crearboton(context),        
    );
  }
Widget  _crearboton(BuildContext context) {
    return FloatingActionButton(
      onPressed: ()=>Navigator.pushNamed(context, 'people'),
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple);
  }
Widget  _crearListado() {
  return FutureBuilder(
    future: peopleProvider.cargarPeople(),
    builder: (BuildContext context, AsyncSnapshot<List<PeopleModel>> snapshot){
      if(snapshot.hasData){        
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context,i)=>_crearItem(context,snapshot.data[i]),
        );
      }else{
        return Center(child:Column(          
         children: <Widget>[
            Icon(Icons.do_not_disturb,size:250.0),
          Text('Sin registros',style: TextStyle(
            fontSize: 25.0,
            color: Colors.deepPurple,
          ),
          ),
         ],
        ),
        );
      }
    },
    );
}

  Widget _crearItem(BuildContext context,PeopleModel people) {
    return Dismissible(
      movementDuration: Duration(milliseconds: 250),
      key:UniqueKey(),
      direction: DismissDirection.startToEnd,
      background: 
        Icon(Icons.delete_forever,color: Colors.black,size: 50.0,)
      ,
      onDismissed: (direcion){
        peopleProvider.eliminarPeople(people.id);
      },
      child: Card(
        child: Column(
          children: <Widget>[
            (people.fotoUrl ==null)
                ? Image(image: AssetImage('assets/no-image.png'))
                : FadeInImage(
                  image: NetworkImage(people.fotoUrl),
                placeholder: AssetImage('assets/jar-loading.gif'),
                height: 350.0,
                width: double.infinity,
                fit:BoxFit.cover,),
              ListTile(
               title: Text('Nombre: ${people.titulo} '),
               subtitle: Text('Edad: ${people.valor}'),       
               onTap:() => Navigator.pushNamed(context, 'people',arguments: people),
             ),
          ],
        ),
      ),
    );

    
  }
}