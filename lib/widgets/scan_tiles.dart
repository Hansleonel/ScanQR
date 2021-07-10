import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';

// creando un Widget para poder optimizar codigo repetido
class ScanTiles extends StatelessWidget {
  final String tipo;
  // creando un constructor para nuestro Widget
  // que nos indique que tiene un propiedad obligatoria, en este caso la propiedad "this.tipo"
  const ScanTiles({@required this.tipo});

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
        // como vemos ahora usaremos el Widget Dismissible() dicho Widget nos permite deslizar un elemento de un lista
        // en este aso de un Widget ListTile() para poder realizar alguna accion en este caso borr dicho elemento
        itemBuilder: (context, i) => Dismissible(
              // la propiedad "key" nos permite crear un identificador unico para cada elemento de la lista, podemos usar el id desde la DataBase
              // o como en este caso usar la funcion "UniqueKey()"
              key: UniqueKey(),
              // podemos personalizar el color al momento de desplazar el elemento de la lista, en este caso le daremos un color red puesto que se realizara un dlt del elemento
              // como vemos debemos de utilizar un Widget dentro de la propiedad "bckgrnd" y luego darle un color a dicho Widget, en este caso usaremos el Widget Container()
              background: Container(
                color: Colors.red,
              ),
              // dicha propiedad nos permite establecer una accion cuando deslizamos un elemento de la lista en este caso dlt del elemento
              onDismissed: (DismissDirection direction) {
                // TODO como vemos dentro una funcion la instanciacion del Provider siempre debe de recibir la propiedad listen en false
                Provider.of<ScanListProvider>(context, listen: false)
                    .borrarScanById(scans[i].id);
              },
              child: ListTile(
                leading: Icon(
                  this.tipo == 'http' ? Icons.map : Icons.home,
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
              ),
            ));
  }
}
