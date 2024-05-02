import 'package:mysql1/mysql1.dart';

class Database {
  // Propiedades
  // Se pone 'final' para bloquear el valor y que nunca cambie.
  final _host = "localhost";
  final _port = 3306;
  final _user = "root";

  // Metodos
  instalacion() async {
    var settings = ConnectionSettings(
      host: this._host,
      port: this._port,
      user: this._user,
    );

    try {
      var conn = await MySqlConnection.connect(settings);
      await _crearDB(conn);
      await _crearTablaUsuario(conn);
      await conn.close();
    } catch (e) {
      print(e);
    }
  }

  //metodo para conexion
  Future<MySqlConnection> conexion() async {
    //Future significa que como es asincrona y no sabemos lo que va a tardar en conectarse cuando este disponible te lo devolvera.
    var settings = ConnectionSettings(
        host: this._host,
        port: this._port,
        user: this._user,
        db: "kapital" //Hay que poner el nombre de la base de datos a la que nos queremos conectar
        );

    return await MySqlConnection.connect(settings);
  }
}

//Metodo para crear base de datos
_crearDB(conn) async {
  await conn.query("CREATE DATABASE IF NOT EXISTS kapital");
  await conn.query("USE kapital");
  print("Conectado a kapital");
}

//Metodo para crear Tabla de Usuario
_crearTablaUsuario(conn) async {
  await conn.query('''CREATE TABLE IF NOT EXISTS usuarios(
      idusuario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
      nombre VARCHAR (50) NOT NULL UNIQUE,
      password VARCHAR (10) NOT NULL
    )''');
  print("Tabla usuario Creada");
}
