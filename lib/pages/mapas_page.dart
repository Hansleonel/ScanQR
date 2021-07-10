import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/widgets/scan_tiles.dart';

class MapasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // como vemos creamos un nuevo Widget ScanTiles() que tiene un parametro obligatorio "tipo" que como vemos recibe un String en este caso "geo"
    return ScanTiles(tipo: 'geo');
  }
}
