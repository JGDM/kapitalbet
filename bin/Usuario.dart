import 'package:mysql1/mysql1.dart';
import 'Database.dart';

class Usuario {
  int? _idusuario;
  String? _nombre;
  String? _password;

  int? get idusuario => _idusuario;
  String? get nombre => _nombre;
  set nombre(String? value) {
    _nombre = value;
  }

  String? get password => _password;
  set password(String? value) {
    _password = value;
  }

  set idusuario(int? value) {
    _idusuario = value;
  }

  Usuario();
  Usuario.sql({idusuario, nombre, password}) {
    this._idusuario = idusuario;
    this._nombre = nombre;
    this._password = password;
  }

  Usuario.fromMap(ResultRow map) {
    this._idusuario = map['idsuario'];
    this._nombre = map['nombre'];
    this._password = map['password'];
  }

  insertarUsuario() async {
    var conn = await Database().conexion();
    try {
      await conn.query('INSERT INTO usuarios(nombre, password) VALUES (?,?)',
          [_nombre, _password]);
      print("$_nombre insertado correctamente");
    } catch (e) {
      print(e);
    } finally {
      await conn.close();
    }
  }

  loginUsuario() async {
    var conn = await Database().conexion();
    try {
      var resultado = await conn
          .query('SELECT * FROM usuarios WHERE nombre = ?', [this._nombre]);
      Usuario usuario = Usuario.fromMap(resultado.first);
      if (this._password == usuario.password) {
        print("Bienvenido $_nombre");
        return usuario;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    } finally {
      await conn.close();
    }
  }
}
