
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
import 'package:mezcalamaras/src/models/contacto_model.dart';

class ContactosProvider {

  final String _url = 'https://amores-7869f.firebaseio.com';


  Future<bool> crearContacto( ContactoModel contacto ) async {
    
    final url = '$_url/contactos.json';

    final resp = await http.post( url, body: contactoModelToJson(contacto) );

    final decodedData = json.decode(resp.body);

    print( decodedData );

    return true;

  }

  Future<bool> editarContacto( ContactoModel contacto ) async {
    
    final url = '$_url/contactos/${ contacto.id }.json';

    final resp = await http.put( url, body: contactoModelToJson(contacto) );

    final decodedData = json.decode(resp.body);

    print( decodedData );

    return true;

  }



  Future<List<ContactoModel>> cargarContactos() async {

    final url  = '$_url/contactos.json';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ContactoModel> contactos = new List();


    if ( decodedData == null ) return [];

    decodedData.forEach( ( id, prod ){

      final prodTemp = ContactoModel.fromJson(prod);
      prodTemp.id = id;

      contactos.add( prodTemp );

    });

     print( contactos[0].id );

    return contactos;

  }


  Future<int> borrarContacto( String id ) async { 

    final url  = '$_url/contactos/$id.json';
    final resp = await http.delete(url);

    print( resp.body );

    return 1;
  }


  Future<String> subirImagen( File imagen ) async {

    final url = Uri.parse('https://api.cloudinary.com/v1_1/dc0tufkzf/image/upload?upload_preset=cwye3brj');
    final mimeType = mime(imagen.path).split('/'); //image/jpeg

    final imageUploadRequest = http.MultipartRequest(
      'POST',
      url
    );

    final file = await http.MultipartFile.fromPath(
      'file', 
      imagen.path,
      contentType: MediaType( mimeType[0], mimeType[1] )
    );

    imageUploadRequest.files.add(file);


    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if ( resp.statusCode != 200 && resp.statusCode != 201 ) {
      print('Algo salio mal');
      print( resp.body );
      return null;
    }

    final respData = json.decode(resp.body);
    print( respData);

    return respData['secure_url'];


  }


}

