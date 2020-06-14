// To parse this JSON data, do
//
//     final productoModel = productoModelFromJson(jsonString);

import 'dart:convert';

ContactoModel contactoModelFromJson(String str) => ContactoModel.fromJson(json.decode(str));

String contactoModelToJson(ContactoModel data) => json.encode(data.toJson());

class ContactoModel {

    String id;
    String nombre;
    String apellido1;
    String apellido2;
    String puesto;
    String numTelefono;
    String fotoURL;

    ContactoModel({
        this.id,
        this.nombre,
        this.apellido1,
        this.apellido2,
        this.puesto,
        this.numTelefono,
        this.fotoURL,
    });

    factory ContactoModel.fromJson(Map<String, dynamic> json) => new ContactoModel(
        id         : json["id"],
        nombre     : json["nombre"],
        apellido1      : json["apellido1"],
        apellido2 : json["apellido2"],
        puesto: json["puesto"],
        numTelefono: json["numTelefono"],
        fotoURL   : json["fotoURL"],
    );

    Map<String, dynamic> toJson() => {
        // "id"         : id,
        "nombre"     : nombre,
        "apellido1"      : apellido1,
        "apellido2" : apellido2,
        "puesto":puesto,
        "numTelefono":numTelefono,
        "fotoURL"    : fotoURL,
    };
}
