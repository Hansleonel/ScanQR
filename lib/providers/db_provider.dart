// creando un singleton para acceder desde cualquier parte de la app
// a esta clase sus metodos y sus propiedades
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:qr_reader/models/scan_model.dart';
export 'package:qr_reader/models/scan_model.dart';

class DBProvider {
  // propiedad estatica a la cual accederemos
  static Database _database;
  // instancia de la clase personalizada, el elemento "_" se usa para establecer
  // un constructor privado
  static final DBProvider db = DBProvider._();
  DBProvider._();

  // metodo para acceder a la database, en este caso tiene que se run getter
  // como sabemos el acceso a la database puede tener un tiempo de espera prolongado
  // es por eso que debemo de usar el async, es por esto que debemos de usar un Future
  // ademas debemos de establecer que dicho Future es de tipo Database por lo que siempre
  // tiene que retrn una variable de tipo Database
  Future<Database> get database async {
    // en caso tengamos una instasiacion correcta de la database
    // tennemos que realizar un rtrn de la misma database
    if (_database != null) return _database;

    // si en caso es la primera vez que accedemos a la database
    // y por lo tanto tenemos que crear una instanciacion entonces debemos de
    // usar las siguienntes lineas
    _database = await initDB();

    // siempre se tiene que retrn a la database ya sea instanciada por primera vez
    // o desde la condicion en la parte superior con la instanciacion ya existente
    return _database;
  }

  // metodo para instanciacion por primera vez para acceder y inicializar a la database
  // como vemos tambien es un Future que devuelve valores del tipo Database es por eso
  // todo que usamos el "<Database>"
  Future<Database> initDB() async {
    // Estableciendo el path donde almacenaremos la Database
    // primero seleccionamos con la variable "documentsDirectory" el path donde se almacenara
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // y segundo estableceremos el nombre de nuestra Database junto con el join que nos permite
    // unir el path de la variable "documentsDirectory" con el nombre de nuestra Database
    // es importante establece el nombre con la extension ".db"
    final path = join(documentsDirectory.path, 'ScansDB.db');
    print(path);

    // Creando la DataBase con la ayuda del Future pre establecido en dart "openDataBase(path)""
    // dicho Future tiene un a propiedad posicional que recibe y debe de ser el path que establecimos en la parte
    // superior con la ayuda del "join()"
    return await openDatabase(
        // propiedad posicional
        path,
        // propiedad nominal "version" dicha propiedad debe de variar si es que se realizan modificacns
        // estructurales como por ejemplo cuando se crean nuevas tablas
        version: 1,
        // con la propiedad onOpen podriamos manejar la Database de distintas maneras dentro de su funcion
        // ademas como podemos ver recibe por default la Database
        onOpen: (Database db) {},
        // esta propiedad se activa solo cuando se crea la base de datos, dicha propiedad recibe dentro de su funcion
        // a la database, ademas de la version provista por nosotros, ademas en caso se realicen operaciones de larga duracion
        // debemos de establecera con un async, ya que la propiedad "onCreate" es un Future
        onCreate: (Database db, int version) async {
      // aqui podemos usar comandos SQL para la creacion de tablas
      await db.execute('''
        CREATE TABLE Scans(
          id INTEGER PRIMARY KEY,
          tipo TEXT,
          valor TEXT
        );
        ''');
    });
  }

  // metodo para la creacionn de registros dentro de nuestra Database
  // metodo con consultas sql personalizadas
  Future<int> nuevoScanRaw(ScanModel nuevoScan) async {
    // creacion de variables usando nuestro objeto "nuevoScan" del tipo ScanModel
    // para su posterior uso en la insercion de datos dentro de la Database
    final id = nuevoScan.id;
    final tipo = nuevoScan.tipo;
    final valor = nuevoScan.valor;

    // TODO accediendo a la base de datos con la ayuda de nuestro getter que se encuentra en la parte superior
    // como sabemos en dicho getter hacemos la comprobacion si es instancia de Database
    // ya existe o se tiene que crear por primera vez
    final db = await database;
    // usando el metodo preestablecido de nuestro paquete sqlflite
    // para la insercion de registros, como vemos usamos las variables inicializadas con las propieades
    // de nuestro ScanModel
    final res = await db.rawInsert('''
      INSERT INTO Scans(id,tipo,valor)
        VALUES ( $id, '$tipo', '$valor')
    ''');

    return res;
  }

  // metodo para la creacion de registros dentro de nuestra Database
  // metodo con consultas sql no personalizadas
  Future<int> nuevoScan(ScanModel nuevoScan) async {
    // TODO accediendo y comprobando la instanciacion de nuestra Database con el uso del getter de la parte superior
    final db = await database;

    // usado metodo prestablecido para la insercion de registros "db.inserts" desde la variable db del tipo Database
    // ademas, como vemos, usaremos el metodo ".toJson" que mapea todas las propiedades de nuestro model ScanModel
    // y construye dicho model como un mapa, esto tiene como ventaja que inserta la totalidad de las propiedades
    // dentro de dicho metodo ".toJson"
    final res = await db.insert('Scans', nuevoScan.toJson());

    // como vemos la variable "res" espera el id del resultado de nuestra consulta
    // en este caso el id de nuestra tabla Scans cada vez que se realiza una insersion
    print(res);

    return res;
  }
}
