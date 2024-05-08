import 'package:mysql1/mysql1.dart';

class Database {
  final _host = "localhost";
  final _port = 3306;
  final _user = "root";

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

  Future<MySqlConnection> conexion() async {
    var settings = ConnectionSettings(
        host: this._host, port: this._port, user: this._user, db: "kapital");

    return await MySqlConnection.connect(settings);
  }
}

_crearDB(conn) async {
  await conn.query("CREATE DATABASE IF NOT EXISTS kapital");
  await conn.query("USE kapital");
}

_crearTablaUsuario(conn) async {
  await conn.query('''CREATE TABLE IF NOT EXISTS usuarios(
      idusuario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
      nombre VARCHAR (50) NOT NULL UNIQUE,
      password VARCHAR (10) NOT NULL
    )''');
}
