import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:qr_reader/pages/directions_page.dart';
import 'package:qr_reader/pages/mapas_page.dart';
import 'package:qr_reader/providers/db_provider.dart';

import 'package:qr_reader/providers/ui_provider.dart';

import 'package:qr_reader/widgets/custom_navigatorbar.dart';
import 'package:qr_reader/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('Historial'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.delete), onPressed: () {})
          ],
        ),
        body: _HomePageBody(),
        bottomNavigationBar: CustomNavigationBar(),
        floatingActionButton: ScanButton(),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked);
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO obtener el valor de la variable global establecida con el provider
    // TODO ademas debemos de especificar a que provider hacemos dicha referencia
    // TODO en este caso a UiProvider() que como sabemos extiende de ChangeNotifier()
    // TODO ademas una vez establecida la instaciacion correctamente
    // TODO podemos acceder al valor y a todas las propieades o metodos de dicha clase
    final uiProvider = Provider.of<UiProvider>(context);

    // TODO accediendo al get de nuestro uiProvider, como sabemos los getters y los setters en Dart
    // TODO son tratados como propieades y no como metodos
    final currentIndex = uiProvider.getSelectedMenuOpt;

    // TODO Accediendo al get Database desde el provider DBProvider
    // TODO como sabemos desde dicho get instaciamos o recuperamos la Database ya instanciada
    // al ser la primera vez que hacemos uso del get, instanciamos la Database a traves del metodo
    // "initDB()" que se encuentra dentro del get
    // DBProvider.db.database;

    // creando nuevo objeto tempScan de clase ScanModel, es decir que dicho objeto debe de tener las propieades que
    // presenta el ScanModel y en caso tenga una propiedad "@required" entonces debe de instanciarse de forma obligatoria
    // ademas como sabemos dentro de nuestro constructor establecemos condiciones para la asignacion de valores
    // a las demas propiedades, en este caso las propieades "id" y "tipo"
    final tempScan = new ScanModel(valor: "https://twitter.com");
    // accediendo al metodo ".nuevoScan()" de nuestro provider DBProvider y enviando el objeto tempScan
    // como vemos al usar el metodo ".nuevoScan()" dentro de nuestro metodo build()
    // estaremos insertando elementos cada vez que hagamos un llamado a dicho metodo build()
    // DBProvider.db.nuevoScan(tempScan);

    // Accediendo a un registro de nuestra Database con el metodo de nuestro Provider DBProvider "getScanById"
    DBProvider.db.getScanById(7).then((value) => print(value.tipo));

    switch (currentIndex) {
      case 0:
        return MapasPage();
      case 1:
        return DirectionsPage();
      default:
        return MapasPage();
    }
  }
}
