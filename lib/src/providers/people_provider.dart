
import 'dart:convert';
import 'dart:io';

import 'package:consultorio_crud/src/models/people_model.dart';
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';


class PeopleProvider{

  final String _url='https://fluttercrud-eb4ca.firebaseio.com';


  Future<bool>crearPeople(PeopleModel people) async{
      final url = '$_url/people.json';

      final resp = await http.post(url,body: peopleModelToJson(people));
      final decodeData = json.decode(resp.body);

      print(decodeData);
      return true;
  } 
  Future<bool>editarPeople(PeopleModel people) async{
      final url = '$_url/people/${people.id}.json';
      final resp = await http.put(url,body: peopleModelToJson(people));
      final decodeData = json.decode(resp.body);
      print(decodeData);
      return true;
  }
  Future<bool>eliminarPeople(String id) async{
      final url = '$_url/people/$id.json';    
      final resp = await http.delete(url);
      final decodeData = json.decode(resp.body);
      return true;
  }

   Future<List<PeopleModel>> cargarPeople()async{
     final url='$_url/people.json';
     final resp = await http.get(url);
     final List<PeopleModel> people = new List();
     final Map<String,dynamic> decodedData=json.decode(resp.body);
     if(decodedData==null)return [];
     decodedData.forEach((key, value) { 
       final peopleTemp=PeopleModel.fromJson(value);
       peopleTemp.id=key;
        people.add(peopleTemp);
     });
     return people;
   }

   Future<String> subirImagen(File imagen) async{
     final url=Uri.parse('https://api.cloudinary.com/v1_1/do30evyat/image/upload?upload_preset=yko4hujn');
     final mimeType=mime(imagen.path).split('/');
     final imageUploadRequest=http.MultipartRequest(
       'POST',
       url
     );
     final file = await http.MultipartFile.fromPath(
       'file',
       imagen.path,
       contentType:MediaType(mimeType[0],mimeType[1])
     );
     imageUploadRequest.files.add(file);

     final streamResponse=await imageUploadRequest.send();
     final resp = await http.Response.fromStream(streamResponse);
     if(resp.statusCode != 200 && resp.statusCode != 201){
       print('Algo salio mal');
       print(resp.body);
       return null;
     }
      final respData=json.decode(resp.body);
      return respData['secure_url'];
   }

}