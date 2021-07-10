import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/widgets/scan_tiles.dart';

class DirectionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Como vemos creamos un nuevo Widget en este caso el Widget ScanTiles() que contenga todo el listado de acuerdo a su tipo
    // en este caso el tipo es "http"
    // ademas como vemos si queremos usar el Widget ScanTiles() debemos de enviar un valor a su propiedad obligatoria "tipo" que en este caso sera "http"
    return ScanTiles(tipo: 'http');
  }
}
