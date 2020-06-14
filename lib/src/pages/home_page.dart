import 'package:flutter/material.dart';
import 'package:mezcalamaras/src/bloc/provider.dart';
//import 'package:formvalidation/src/models/producto_model.dart';
//import 'package:formvalidation/src/providers/productos_provider.dart';
import 'package:mezcalamaras/src/models/contacto_model.dart';
import 'package:mezcalamaras/src/providers/contactos_provider.dart';
class HomePage extends StatelessWidget {
  
  final contactosProvider = new ContactosProvider();
  
  @override
  Widget build(BuildContext context) {

    final bloc = Provider.of(context);
    

    return Scaffold(
      appBar: AppBar(
        title: Text('Directorio empresarial')
      ),
      body: _crearListado(),
      //floatingActionButton: _crearBoton( context ),
    );
  }


  Widget _crearListado() {

    return FutureBuilder(
      future: contactosProvider.cargarContactos(),
      builder: (BuildContext context, AsyncSnapshot<List<ContactoModel>> snapshot) {
        if ( snapshot.hasData ) {

          final contactos = snapshot.data;

          return ListView.builder(
            itemCount: contactos.length,
            itemBuilder: (context, i) => _crearItem(context, contactos[i] ),
          );

        } else {
          return Center( child: CircularProgressIndicator());
        }
      },
    );
  }
Widget _miItem(BuildContext context, ContactoModel contacto ){
  
  return ListTile(
      
    
          
              title: Text('${ contacto.nombre }  ${ contacto.apellido1 } ${ contacto.apellido2 }'),
              leading: CircleAvatar(
              backgroundImage: NetworkImage(contacto.fotoURL),
            

              
  ),
              subtitle: Text( contacto.numTelefono ),
        
              onTap: () => Navigator.pushNamed(context, 'contacto', arguments: contacto  ),
            );
}
  Widget _crearItem(BuildContext context, ContactoModel contacto ) {

    
      return Card(
        child: Column(
          
          children: <Widget>[
            Container( 
              //height: 200,
              
              child: ListTile(
              
              title: Text('${ contacto.nombre }  ${ contacto.apellido1 } ${ contacto.apellido2 }'),
             leading: CircleAvatar(
               radius: 28.0, 
               backgroundColor: Colors.white,
              backgroundImage: NetworkImage(contacto.fotoURL),
             
  ),
              subtitle: Text( contacto.numTelefono ),
        
              onTap: () => Navigator.pushNamed(context, 'contacto', arguments: contacto  ),
            ),),
       
           

          ],
            
        ),
      );
   
      

    

  }


  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon( Icons.add ),
      backgroundColor: Colors.deepPurple,
      onPressed: ()=> Navigator.pushNamed(context, 'contacto'),
    );
  }

}