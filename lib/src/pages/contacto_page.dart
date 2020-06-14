import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


import 'package:mezcalamaras/src/models/contacto_model.dart';
import 'package:mezcalamaras/src/providers/contactos_provider.dart';
import 'package:mezcalamaras/src/utils/utils.dart' as utils;


class ContactoPage extends StatefulWidget {

  @override
  _ContactoPageState createState() => _ContactoPageState();
}

class _ContactoPageState extends State<ContactoPage> {
  
  final formKey     = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final contactoProvider = new ContactosProvider();

  ContactoModel producto = new ContactoModel();
  bool _guardando = false;
  File foto;

  @override
  Widget build(BuildContext context) {

    final ContactoModel prodData = ModalRoute.of(context).settings.arguments;
    if ( prodData != null ) {
      producto = prodData;
    }
    
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Contacto'),
      
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                 Text('  '+producto.nombre+' '+producto.apellido1+' '+producto.apellido2+'  ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0,
                                      fontFamily: 'sans-serif-light',
                                      backgroundColor: Colors.black,
                                      color: Colors.white),
                            ),
                _mostrarFoto(),
                Text('\nNúmero Telefonico: '+producto.numTelefono,
                style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                      fontFamily: 'sans-serif-light',
                                      
                                      color: Color.fromRGBO(139, 109, 68, 1)),),
                
                Text('\nPuesto: '+producto.puesto+'\nRegión: Sur'+'\nEnvasado: Oaxaca, Centro',

                style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                      fontFamily: 'sans-serif-light',
                                      
                                      color: Color.fromRGBO(139, 109, 68, 1)),),
                                      
                                      //_crearNombre(),
               // _crearPrecio(),
               // _crearDisponible(),
               // _crearBoton()
              ],
            ),
          ),
        ),
      ),
    );

  }

  Widget _crearNombre() {

    return TextFormField(
      
      //initialValue: producto.nombre,
      //textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Contacto'+producto.nombre
      ),
     
    );

  }

  Widget _crearPrecio() {
    return TextFormField(
      initialValue: producto.apellido1.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Precio'
      ),
    //  onSaved: (value) => producto.apellido1 = double.parse(value),
      validator: (value) {

        if ( utils.isNumeric(value)  ) {
          return null;
        } else {
          return 'Sólo números';
        }

      },
    );
  }

  Widget _crearDisponible() {

   

  }



  Widget _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      color: Colors.deepPurple,
      textColor: Colors.white,
      label: Text('Guardar'),
      icon: Icon( Icons.save ),
      onPressed: ( _guardando ) ? null : _submit,
    );
  }

  void _submit() async {

    

    if ( !formKey.currentState.validate() ) return;

    formKey.currentState.save();

    setState(() {_guardando = true; });

    if ( foto != null ) {
      producto.fotoURL = await contactoProvider.subirImagen(foto);
    }



    if ( producto.id == null ) {
      contactoProvider.crearContacto(producto);
    } else {
      contactoProvider.editarContacto(producto);
    }


    // setState(() {_guardando = false; });
    mostrarSnackbar('Registro guardado');

    Navigator.pop(context);

  }


  void mostrarSnackbar(String mensaje) {

    final snackbar = SnackBar(
      content: Text( mensaje ),
      duration: Duration( milliseconds: 1500),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);

  }


  Widget _mostrarFoto() {

    if ( producto.fotoURL != null ) {
      
      return FadeInImage(
        image: NetworkImage( producto.fotoURL ),
        placeholder: AssetImage('assets/jar-loading.gif'),
        
                
        
        fit: BoxFit.cover,
      );

    } else {

      return Image(

        image: AssetImage( foto?.path ?? 'assets/no-image.png'),
        height: 300.0,
        fit: BoxFit.cover,

      );

    }

  }


  _seleccionarFoto() async {

    _procesarImagen( ImageSource.gallery );

  }
  
  
  _tomarFoto() async {

    _procesarImagen( ImageSource.camera );

  }

  _procesarImagen( ImageSource origen ) async {

    foto = await ImagePicker.pickImage(
      source: origen
    );

    if ( foto != null ) {
      producto.fotoURL = null;
    }

    setState(() {});

  }


}



