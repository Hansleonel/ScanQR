import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:qr_reader/pages/directions_page.dart';
import 'package:qr_reader/pages/mapas_page.dart';

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
