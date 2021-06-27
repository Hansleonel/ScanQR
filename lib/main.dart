import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:qr_reader/pages/home_page.dart';
import 'package:qr_reader/pages/mapa_page.dart';

import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO Usaremos el Widget MultiProvider para poder tener acceso de manera global
    // TODO a una variable creada dentro de una clase que extienda de ChangeNotifier()
    // TODO ademas dicha extension nos permitira realizar escuchar cualquier modificacion
    // TODO de dicha variable con el uso de un set() y un notifierListener()
    return MultiProvider(
      // TODO la propiedad providers de nuestro Widget MultiProvider() nos permite
      // TODO realizar instancias globales de nuestro UiProvider(), o de los demas
      // TODO providers creados
      providers: [
        // provider para saber cual es la pagina seleccionada desde el Widget
        // "CustomNavigationBar()", ya sea la pagina "MapasPage()" o "DirectionsPage()"
        ChangeNotifierProvider(create: (context) => new UiProvider()),
        // provider para actualizar la vista del listado de Scans de acuerdo al metodo que se use
        // ya sea para ver todos los scans o borrarlos por tipo o todos, o para crear un nuevo elemento
        ChangeNotifierProvider(create: (context) => new ScanListProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Reader',
        initialRoute: 'home',
        routes: {
          'home': (BuildContext context) => HomePage(),
          'mapa': (BuildContext context) => MapaPage()
        },
        // TODO podemos manejar el theme de nuestra aplicacion desde el main
        // TODO con la propiedad "theme" de nuestro Widget MaterialApp() que como sabemos es
        // TODO nuestro Widget Principal, en caso se quiera usar el theme dark
        // TODO podemos usar ThemeData.dark(), en esta ocacion usaremos un theme personalizado
        theme: ThemeData(
            primaryColor: Colors.deepPurple,
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.deepPurple)),
      ),
    );
  }
}
