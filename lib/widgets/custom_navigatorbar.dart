import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';

class CustomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO Instanciando la variable global de nuestro Provider
    // TODO recordar establecer el nombre de clase de neustro Provider
    // TODO en este caso es UiProvider
    // TODO como sabemos ahora podemos acceder a todos los metodos y propiedades
    // TODO de nuestro uiProvider
    final uiProvider = Provider.of<UiProvider>(context);

    // TODO con esta variable podemos manejar el estado de seleccion de los tabs
    // TODO de nuestro Widget BottomNavigatorBar(), siendo para el primer tab el valor
    // TODO de 0 y para el segundo tab el valor de 1
    // TODO adicionalmente estamos accediendo a la propiedad get de nuestra clase UiProvider()
    // TODO recordemos que los getters y setters son tratados en Dart como propiedades y no metodos
    final currentIndex = uiProvider.getSelectedMenuOpt;

    // TODO recordemos que el Widget ButtomNavigationBar() necesita por
    // TODO lo menos dos ButtomNavigationBarItem() dentro de su propiedad item
    return BottomNavigationBar(
        onTap: (int indexSelectedItem) {
          print('selected item =  $indexSelectedItem');
          // TODO accediendoa nuestra propiedad set de nuestra clase UiProvider()
          // TODO recordemos que los getters y los setters dentro de dart son tratados
          // TODO como propieades y no como metodos, es por eso que no neceismos enviar
          // TODO el parametro que nos pediria el .setSelectedMenuOpt si fuese un metodo
          // TODO y solo necesitamos igual dicha propiedad a el nuevo valor, que en este caso
          // TODO lo establece la funcion que recibe la propiedad onTap() de nuestro Widget BottomNavigationBar()
          uiProvider.setSelectedMenuOpt = indexSelectedItem;
        },
        currentIndex: currentIndex,
        elevation: 0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Mapa'),
          BottomNavigationBarItem(
              icon: Icon(Icons.compass_calibration), label: 'Direcciones'),
        ]);
  }
}
