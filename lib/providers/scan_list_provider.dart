import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:qr_reader/providers/db_provider.dart';

// Provider que extiende del ChangeNotifier para usar provider por como gestor de estado
class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];

  // establecemos el tipo seleccionado para mostrar solo los scans que sean del tipo http
  // es decir solo para modificar la vista del Widget "MapasPage()"
  String tipoSeleccionado = 'http';

  // metodo para crear un nuevo Scan en nuestro Database
  // ademas de agregar dicho Scan creado a nuestro listado List<ScanModel> scans
  // dicho metodo recibe el valor de scanea nuestro button principal
  Future<ScanModel> nuevoScan(String valor) async {
    // instanciando un nuevo objeto de nombre "nuevoScan" y de la Class ScanModel
    // como sabemos dicha Class tiene en su cosntructor un valor obligatorio
    // es por eso que debemos de enviarle siempre el valor recibido por el metodo nuevoScan(String valor)
    final nuevoScan = new ScanModel(valor: valor);
    // creando un nuevo registro dentro de nuestra Database gracias al metodo de nuesrto DBProvider "db.nuevoScan()"
    // como sabemos dicho metodo nos devuelve el id del nuevo registro
    // dicho id lo almancenaremos dentro de una nueva variable, en este caso la variable "id"
    // ademas observamos que la creacion del registro se da ya sea del tipo "http" o del tipo "geo"
    // es decir siempre se crearan los registro pero posteriormente debemos de tener una condicional
    // para que solo se actualice el Widget "MapasPage()" que solo muestra a los del tipo
    // "http"
    final id = await DBProvider.db.nuevoScan(nuevoScan);
    // asignando el id de la Database al objeto "nuevoScan" puesto que dicho id lo tiene que asignar la misma Database
    nuevoScan.id = id;

    // una vez creado el objeto nuevoScan y ademas creado el nuevoRegistro con la ayuda del metodo "db.nuevoScan()"
    // agregamos dicho registeo a nuetra lista "List<ScanModel> scans" posteriormente
    // notificamos dicha modificacin para  actualizar la interfaz
    // ademas, como sabemos en este primer caso nos interesa solo actualizar el Widget "MapasPage()"
    // es por eso que debemos de realizar dicha notificacion solo cuando sea del tipo "http"
    if (this.tipoSeleccionado == nuevoScan.tipo) {
      // solo agregamos a nuestra lista "List<ScanModel> scans" todo el objeto "nuevoScan"
      // cuando del tipo "http"
      this.scans.add(nuevoScan);
      // notificamos dicha modificacnn para poder actualizar nuestra interface
      notifyListeners();
    }

    return nuevoScan;
  }

  // cargar todos los scans desde la Database
  cargarScans() async {
    // capturamos todos los registros de la Database con el metodo "db.getAllScans()"
    final scansDataBase = await DBProvider.db.getAllScans();
    // rellenamos el listado "List<ScanModel> scans"
    scans = [...scansDataBase];
    // una vez cargados los registro de nuestra Database dentro de nuestro Listado "List<ScanModel> scans"
    // debemos de notificar dicha modificcn con la ayuda de nuestro metodo "notifyListeners()"
    notifyListeners();
  }

  // cargamos solo los scans de un mismo tipo, de acuerdo a la variable recibida con el nombre de type
  cargarScansByType(String type) async {
    // capturamos todos los registros que sean del mismo tipo en este caso dicho tipo es igual al valor
    // de la variable "type" recibida
    final scansDataBaseByType = await DBProvider.db.getScansByType(type);
    // rellenamos el listado "List<ScanModel> scans"
    scans = [...scansDataBaseByType];

    // adicionalmente como ya recibimos un tipo debemos de modificr el valor de nuestra variable "tipoSeleccionado"
    this.tipoSeleccionado = type;

    // una vez cargados los registros de nuestra Database dentro de nuestro Listado "List<ScanModel> scans" ademas de
    // modificr el valor de nuestra variable "tipoSeleccionado"
    // debemos de notificar dicha modificcn de nuestra lista "List<ScanModel> scans" con la ayuda de nuestro metodo "notifyListener()"
    notifyListeners();
  }

  // borrando todos los scan de la Database
  borrarTodos() async {
    // usamos el metodo "db.deleteAllScans()" para borrar todos los scan de nuestra Database
    await DBProvider.db.deleteAllScans();
    // rellenamos nuestra lista "List<ScanModel> scans" con un arreglo vacio puesto que previamente
    // borramos todos los scans de nuestra Database
    this.scans = [];
    // notificamos de dicho borrd dentro de la Database y dentro de nuestro listado "List<ScanModel> scans"
    // para poder actualizar nuestra interface
    notifyListeners();
  }

  // borrando scans de la Database por id
  borrarScanById(int id) async {
    // usamos el metodo "db.deleteScanById()" para borrar un solo registro de acuerdo a su id
    await DBProvider.db.deleteScanById(id);
    // una vez borrado el registro debemos de actualizar nuestro Listado "List<ScanModel> scans"
    // en esta ocacion podemos usar el metodo "cargarScansByType(type)" para poder actualizar tanto nuestra lista
    // "List<ScanModel> scans" como nuestra interfaz puesto que no necesuitamios volver a usar la funcion
    // notifyListener(), puesto que el metodo "cargarScansByType(type)" ya lo usa
    // TODO en caso no necesitemos recargar nuestra interfaz como por ejemplo con el uso del Widget Dismissible()
    // no es necesario volver a usar la funcion "cargarScansByType()"
    // cargarScansByType(this.tipoSeleccionado);
  }
}
