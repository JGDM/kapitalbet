import 'dart:io';
import 'usuario.dart';

class App {
  insertarMenu() async {
    int? opcion;
    do {
      stdout.writeln('Elige opcion 1 u opcion 2');
      String respuesta = stdin.readLineSync() ?? 'e';
      opcion = int.tryParse(respuesta);
    } while (opcion == null || opcion != 1 && opcion != 2 && opcion != 3);
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
  }

  menuLogueado(Usuario usuario) async {
    int? respuesta2;
    String? nombre = usuario.nombre;
    do {
      stdout.writeln('Hola $nombre,'
          '¿Qué quieres hacer 1 listar usuarios, 2 listar tus mascotas, 3 crear mascota?');
      String respuesta = stdin.readLineSync() ?? 'e';
      respuesta2 = int.tryParse(respuesta);
    } while (respuesta2 == null ||
        respuesta2 != 1 && respuesta2 != 2 && respuesta2 != 3);
    switch (respuesta2) {
      case 1:
        await listarUsuario();
        menuLogueado(usuario);
        break;
      case 2:
        print(usuario.idusuario);
        await listarMascotasUsuario(usuario.idusuario);
        menuLogueado(usuario);
        break;
      case 3:
        print('adios');
        exit;
    }
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
      menuLogueado(resultado);
    }
  }
}
