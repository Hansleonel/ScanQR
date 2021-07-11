import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

// creando un metodo que sera llamado desde algunas partes de la application
// enn este caso crearemos una carpeta utils para este tipo de de metodos repetitivos
launchURL(BuildContext context, ScanModel scan) async {
  final url = scan.valor;

  if (scan.tipo == 'http') {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  } else {
    print('geo');
    // en caso el scan seleccioando sea del tipo "geo" debemos de ir a la pagina "MapaPage()"
    Navigator.pushNamed(context, 'mapa', arguments: scan);
  }
}
