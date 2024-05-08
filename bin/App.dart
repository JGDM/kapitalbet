import 'dart:io';
import 'partido.dart';
import 'usuario.dart';

class App {
  insertarMenu() async {
    int? opcion;
    do {
      stdout.writeln('1 Crear Usuario o 2 Log in');
      String respuesta = stdin.readLineSync() ?? 'e';
      opcion = int.tryParse(respuesta);
    } while (opcion == null || opcion != 1 && opcion != 2);
    switch (opcion) {
      case 1:
        crearUsuario();
        break;
      case 2:
        login();
        break;
      default:
        print('Opcion no valida');
    }
  }

  crearUsuario() {
    Usuario usuario = new Usuario();
    stdout.writeln('Introduce un nombre de usuario');
    usuario.nombre = stdin.readLineSync();
    stdout.writeln('introduce una contraseña');
    usuario.password = stdin.readLineSync();
    usuario.insertarUsuario();
    menuLogueado(usuario);
  }

  menuLogueado(Usuario usuario) async {
    await Partido().imprimirpartidos();
  }

  login() async {
    Usuario usuario = new Usuario();
    stdout.writeln('Escriba el nombre de usuario');
    usuario.nombre = stdin.readLineSync();
    stdout.writeln('dime tu contraseña');
    usuario.password = stdin.readLineSync();
    var resultado = await usuario.loginUsuario();
    if (resultado == false) {
      stdout.writeln('nombre o contraseña incorrectos');
    } else {
      menuLogueado(usuario);
    }
  }
}
