import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';

class MapasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // como vemos instanciamos un nuevo ScanListProvider para poder, esta vez si, redibujar el Widget Mapa
    // ademas debemos de observar que generalmente el redibujado de los Widgets se dan dentro de el metodo "build()" de los Widgets
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    return ListView.builder(
        // usando la propiedad itemCount para conocer el tamaño de nuestro ListView.Builder()
        // como vemos debe de ser del tamaño de nuestra Lista de ScanModel "List<ScanModel> scans"
        // esta lista ya esta llena, puesto que hacemos un llamado a nuestro metodo "cargarScansByType(type)"
        // en nuestro Widget Padre HomePage() dentro del "body" que recibe un Widget _HomePageBody()
        itemCount: scans.length,
        // como vemos usaremos el Widget ListView.Builder y la propiedad nominal
        // "itemBuilder" que recibe una funcion y dicha funcion recibe como parametro
        // un BuildContext context que nos permite saber en que parte del arbol de Widgets nos encontramos
        // y un Int i que nos permite saber el indice de cada elemento de nuestro Widget ListView.builder()
        itemBuilder: (context, i) => ListTile(
              leading: Icon(
                Icons.map,
                color: Theme.of(context).primaryColor,
              ),
              // como vemos usamos la lista "List<ScanModel> scans" y el indice "i"
              // para conocer el valor de la propiedad "title" de cada elemento de nuestra lista
              // para este caso usaremos la propiedad "valor" de nuestro Model ScanModel
              title: Text(scans[i].valor),
              // como vemos usamos la lista "List<ScanModel> scans" y el indice "i"
              // para conocer el valor de la propiedad "subtitle" de cada elemento de neuestra lista
              // en este caso usaremos la propiedad "id" de nuestro Model ScanModel
              subtitle: Text(scans[i].id.toString()),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey,
              ),
              onTap: () => print(scans[i].id),
            ));
  }
}
