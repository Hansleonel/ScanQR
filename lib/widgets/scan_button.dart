import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';

class ScanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        elevation: 0,
        onPressed: () async {
          final barCodeScanHttpRes = 'https://fernandoH.com';
          final barCodeScanGeoRes = 'geo:15.33, 15.66';
          // String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          //    '#3D8BEF', 'Cancel', false, ScanMode.QR);
          // print(barcodeScanRes);

          // como vemos intanciamos el provider scanListProvider para poder utilizar sus metodos
          // en este caso su metodo de insercion de nuevos scans
          // ademas debemos de obsevar que la propiedad "listen" debe de recibir el valor de false
          // puesto que no queremos redibujar este Widget ScanButton, adicionalmente no debemos de usar dentro de una funcion
          // como "onPressed" un notifyListener()
          final scanListProvider =
              Provider.of<ScanListProvider>(context, listen: false);

          scanListProvider.nuevoScan(barCodeScanHttpRes);
          scanListProvider.nuevoScan(barCodeScanGeoRes);
        });
  }
}
