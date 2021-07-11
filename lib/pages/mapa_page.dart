import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_model.dart';

class MapaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // recibiendo los argumentos de la pagina desde la cual llegamos a la pagina MapaPage()
    final ScanModel scan = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Center(
        child: Text(scan.valor),
      ),
    );
  }
}
