import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  Completer<GoogleMapController> _controller = Completer();

  // como estamos en un statefulWidget podemos modificar ciertos valores y actualizar la interfaz de acuerdo a esa actualizacion
  // con nuestra funcion predeterminada y solo de los StatefulWidgets "setState((){})"
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    // recibiendo los argumentos de la pagina desde la cual llegamos a la pagina MapaPage()
    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    // creacion de marcadores
    Set<Marker> markers = new Set<Marker>();
    markers.add(
        new Marker(markerId: MarkerId('geo01'), position: scan.getLatLng()));

    // usamos una variable "inintialPosition" del tipo CameraPosition para usar sus propiedades
    // target que recibe una latitud y longitud
    // y zoom que recibe la amplitud de la vista del punto inicial
    final CameraPosition initialPosition = CameraPosition(
        // como vemos el objecto de tipo ScanModel "scan" para poder utilizar su metodo ".getLatLng()"
        target: scan.getLatLng(),
        // propiedad que nos permite manejar el zoom del valor de la propiedad "target"
        zoom: 16,
        // propiedad que nos permite manejar el grado de incln de la propiedad "target"
        tilt: 50);

    return Scaffold(
      appBar: AppBar(
        title: Text('Location'),
        actions: [
          IconButton(
            icon: Icon(Icons.location_on),
            // usaremos la propiedad "onPreseed" para recibir una funcion anonima que nos permite movernos a nuestro punto inicial
            // dicho metodo contiene un await es por eso que debemos de definirlo como async
            onPressed: () async {
              final GoogleMapController actionController =
                  await _controller.future;
              actionController.animateCamera(
                  CameraUpdate.newCameraPosition(initialPosition));
            },
          )
        ],
      ),
      // la propiedad body del Widget Scaffold() recibe el Widget GoogleMap()
      body: GoogleMap(
        myLocationButtonEnabled: false,
        // la propiedad mapType del Widget GoogleMap() recibe el tipo de mapa que queremos mostrar
        // en este caso sera del tipo normal
        mapType: mapType,
        // la propiedad initialCameraPosition del Widget GoogleMap() recibe la posicion inicial que se mostrara en el mapa
        initialCameraPosition: initialPosition,
        markers: markers,
        // la propiedad onMapCreated recibe una funcion que se lanzara cuando el papa este listo para usarse
        onMapCreated: (GoogleMapController googleMapController) {
          _controller.complete(googleMapController);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.layers),
        onPressed: () {
          // condicion para que el valor de la variable "mapType" nos permita modificar de el MapType.normal al MapType.satellite
          if (mapType == MapType.normal) {
            mapType = MapType.satellite;
          } else {
            mapType = MapType.normal;
          }

          setState(() {});
        },
      ),
    );
  }
}
