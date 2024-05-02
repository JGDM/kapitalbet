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
      'ganadosLocal': dato['scores']['home']['win'],
      'perdidosLocal': dato['scores']['home']['loss'],
      'ganadosVisitante': dato['scores']['visitors']['win'],
      'perdidosVisitante': dato['scores']['visitors']['loss'],
      'lineasPuntosLocal': dato['scores']['home']['linescore'],
      'lineasPuntosVisitante': dato['scores']['visitors']['linescore'],
      'tiemposEmpatados': dato['timesTied'],
      'cambiosLider': dato['leadChanges'],
    };
  }

  obtenerpartidostemporada() async {
    Uri url = Uri.parse("https://v2.nba.api-sports.io/games?date=2023-02-03");
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
        print('Liga: ${partido.league}');
        print('Temporada: ${partido.season}');
        print('Fecha de inicio: ${partido.fechaInicio}');
        print('Estadio: ${partido.estadio}');
        print('Ciudad: ${partido.ciudad}');
        print('Equipo local: ${partido.equipoLocal}');
        print('Equipo visitante: ${partido.equipoVisitante}');
        print('Estadísticas:');
        print(
            ' - Puntos del equipo local: ${partido.estadisticas?["puntosLocal"]}');
        print(
            ' - Puntos del equipo visitante: ${partido.estadisticas?['puntosVisitante']}');
        print(
            ' - Ganados del equipo local: ${partido.estadisticas?['ganadosLocal']}');
        print(
            ' - Perdidos del equipo local: ${partido.estadisticas?['perdidosLocal']}');
        print(
            ' - Ganados del equipo visitante: ${partido.estadisticas?['ganadosVisitante']}');
        print(
            ' - Perdidos del equipo visitante: ${partido.estadisticas?['perdidosVisitante']}');
        print(
            ' - Líneas de puntos del equipo local: ${partido.estadisticas?['lineasPuntosLocal']}');
        print(
            ' - Líneas de puntos del equipo visitante: ${partido.estadisticas?['lineasPuntosVisitante']}');
        print(
            ' - Veces empatados: ${partido.estadisticas?['tiemposEmpatados']}');
        print(' - Cambios de líder: ${partido.estadisticas?['cambiosLider']}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
