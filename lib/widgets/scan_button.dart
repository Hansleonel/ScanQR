import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utils/utils.dart';

class ScanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        elevation: 0,
        onPressed: () async {
          // final barCodeScanHttpRes = 'https://google.com';
          // final barCodeScanGeoRes = 'geo:-12.099917, -77.063792';
          String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
              '#3D8BEF', 'Cancel', false, ScanMode.QR);
          print(barcodeScanRes);

          // en caso el scaneo tenga un error simplemente no realizar alguna action
          if (barcodeScanRes == '-1') {
            print('error ScanCd');
            return;
          }

          // como vemos intanciamos el provider scanListProvider para poder utilizar sus metodos
          // en este caso su metodo de insercion de nuevos scans
          // ademas debemos de obsevar que la propiedad "listen" debe de recibir el valor de false
          // puesto que no queremos redibujar este Widget ScanButton, adicionalmente no debemos de usar dentro de una funcion
          // como "onPressed" un notifyListener()
          final scanListProvider =
              Provider.of<ScanListProvider>(context, listen: false);

          // final scan = await scanListProvider.nuevoScan(barCodeScanHttpRes);
          // modificamos el metodo "nuevoScan" de nuestro provider ScanListProvider()
          // para que este nos devuelva un scan, de esta manera podemos utilizar el metodo de nuestro utils
          // "launchURL()" recordar que si usamos queremos usar el valor que nos devuelve un Future
          // debemos de usar la instruccion "await"
          final scan = await scanListProvider.nuevoScan(barcodeScanRes);

          launchURL(context, scan);
        });
  }
}
