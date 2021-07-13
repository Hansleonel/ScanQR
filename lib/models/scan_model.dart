import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

ScanModel scanModelFromJson(String str) => ScanModel.fromJson(json.decode(str));
String scanModelToJson(ScanModel data) => json.encode(data.toJson());

class ScanModel {
  int id;
  String tipo;
  String valor;

  // TODO ponemos como valor obligatorio dentro del constructor a la propiedad "valor" con
  // TODO la ayuda del @required, es decir que si queremos hacer uso de el ScanModel
  // TODO por lo menos debemos de enviar el valor de la propiedad "valor"
  ScanModel({this.id, this.tipo, @required this.valor}) {
    if (this.valor.contains('http')) {
      this.tipo = 'http';
    } else {
      this.tipo = 'geo';
    }
  }

  // metodo para obtener la longitud y latitud desde el valor de la propiedad "valor
  LatLng getLatLng() {
    // con la siguiente linea primero separamos los 4 primeros letras del string con nel metodo predeterminado ".substring()"
    // ademas haemos una separacion adicional con metodo predeterminando ".split()" y hacemos la separacion por el valor enviado en este caso ","
    final latLng = this.valor.substring(4).split(',');
    final lat = double.parse(latLng[0]);
    final lng = double.parse(latLng[1]);

    return LatLng(lat, lng);
  }

  factory ScanModel.fromJson(Map<String, dynamic> json) =>
      ScanModel(id: json["id"], tipo: json["tipo"], valor: json["valor"]);

  Map<String, dynamic> toJson() => {"id": id, "tipo": tipo, "valor": valor};
}
