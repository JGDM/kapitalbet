import "package:http/http.dart" as http;

import 'dart:io';

import 'dart:convert';

class Partido {
  String? league;
  String? season;
  String? fechaInicio;
  String? estadio;
  String? ciudad;
  String? pais;
  String? equipoLocal;
  String? equipoVisitante;
  Map<String, dynamic> estadisticas;
  Partido({
    this.league,
    this.season,
    this.fechaInicio,
    this.estadio,
    this.ciudad,
    this.pais,
    this.equipoLocal,
    this.equipoVisitante,
    required this.estadisticas,
  });

  obtenerpartidostemporada() async {
    Uri url = Uri.parse("https://v2.nba.api-sports.io/games?date=2022-03-09");
    var respuesta = await http.get(url, headers: {
      'x-rapidapi-host': 'v2.nba.api-sports.io',
      'x-rapidapi-key': '906c644d50b216417ceedc1f2248a1b7'
    });
    try {
      if (respuesta.statusCode == 200) {
        var datos = json.decode(respuesta.body);
        print(datos);
      } else if (respuesta.statusCode == 404) {
        throw ("Los datos no son correctos");
      } else
        throw ("Ha habido un error de conexión");
    } catch (e) {
      stdout.writeln(e);
    }
  }
}
