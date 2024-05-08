import "package:http/http.dart" as http;

import 'dart:io';

import 'dart:convert';

class Partido {
  String? id;
  String? league;
  String? season;
  String? fechaInicio;
  String? estadio;
  String? ciudad;
  String? pais;
  String? equipoLocal;
  String? equipoVisitante;
  Map? estadisticas;
  Partido();
  Partido.fromApi(dato) {
    id = dato['id'].toString();
    league = dato['league'];
    season = dato['season'].toString();
    fechaInicio = dato['date']['start'];
    estadio = dato['arena']['name'];
    ciudad = dato['arena']['city'];
    equipoLocal = dato['teams']['home']['name'];
    equipoVisitante = dato['teams']['visitors']['name'];
    estadisticas = {
      'puntosLocal': dato['scores']['home']['points'],
      'puntosVisitante': dato['scores']['visitors']['points'],
      'lineasPuntosLocal': dato['scores']['home']['linescore'],
      'lineasPuntosVisitante': dato['scores']['visitors']['linescore'],
    };
  }

  obtenerpartidostemporada() async {
    String? fechapartido;
    stdout.writeln('Introduce la fecha en formato AAAA-MM-DD');
    fechapartido = stdin.readLineSync() ?? 'e';
    Uri url =
        Uri.parse("https://v2.nba.api-sports.io/games?date=$fechapartido");
    var respuesta = await http.get(url, headers: {
      'x-rapidapi-host': 'v2.nba.api-sports.io',
      'x-rapidapi-key': '906c644d50b216417ceedc1f2248a1b7'
    });
    try {
      if (respuesta.statusCode == 200) {
        var datos = json.decode(respuesta.body);
        List<Partido> partidos = [];

        for (var elemento in datos['response']) {
          partidos.add(Partido.fromApi(elemento));
        }
        return partidos;
      } else if (respuesta.statusCode == 404) {
        throw ("Los datos no son correctos");
      } else
        throw ("Ha habido un error de conexión");
    } catch (e) {
      stdout.writeln(e);
    }
  }

  imprimirpartidos() async {
    try {
      List<Partido> partidos = await obtenerpartidostemporada();
      for (var partido in partidos) {
        print('Temporada: ${partido.season}');
        print('Fecha de inicio: ${partido.fechaInicio}');
        print('Estadio: ${partido.estadio}');
        print('Ciudad: ${partido.ciudad}');
        print('Equipo local: ${partido.equipoLocal}');
        print('Equipo visitante: ${partido.equipoVisitante}');
        print('Estadísticas:');
        print(
            ' - Puntos de ${partido.equipoLocal}: ${partido.estadisticas?["puntosLocal"]}');
        print(
            ' - Puntos de ${partido.equipoVisitante} : ${partido.estadisticas?['puntosVisitante']}');
        print(
            ' - Puntos en cada cuarto del equipo local: ${partido.estadisticas?['lineasPuntosLocal']}');
        print(
            ' - Puntos en cada cuarto del equipo visitante: ${partido.estadisticas?['lineasPuntosVisitante']}');
        if (partido.estadisticas?["puntosLocal"] >
            partido.estadisticas?['puntosVisitante']) {
          print(
              'El equipo ganador es ${partido.equipoLocal} por $diferenciapuntos()');
        } else
          print(
              'El ganador es ${partido.equipoVisitante} por $diferenciapuntos() ');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  diferenciapuntos(estadisticas) {
    int? resultado;
    if (estadisticas?["puntosLocal"] > estadisticas["puntosVisitante"]) {
      resultado =
          (estadisticas["puntosLocal"]) - (estadisticas["puntosVisitante"]);
      print(resultado);
      return resultado;
    } else {
      resultado =
          (estadisticas?["puntosVisitante"]) - (estadisticas?["puntosLocal"]);
      print(resultado);
      return resultado;
    }
  }
}
