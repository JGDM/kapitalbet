import "package:http/http.dart" as http;
import 'dart:convert';
import 'dart:io';
class Partido {
String? nombreLoc;
String? nombreVis;
String? puntosLoc;
String? puntosVis;
List<Partido> partidos;

Partido.fromAPI(datos, estadisticas){
  
}
obtenerpartidostemporada() async {
  Uri url = Uri.parse("https://v2.nba.api-sports.io/games?date=2022-03-09");
  var respuesta = await http.get(url, headers: {
    'x-rapidapi-host': 'v2.nba.api-sports.io',
    'x-rapidapi-key': '906c644d50b216417ceedc1f2248a1b7'
  });
  try {
    if (respuesta.statusCode == 200) {
      var partidos = json.decode(respuesta.body);
      return partidos;
    } else if (respuesta.statusCode == 404) {
      throw ("Los datos no son correctos");
    } else
      throw ("Ha habido un error de conexión");
  } catch (e) {
    stdout.writeln(e);
  }
}
listaPartidos(){
  partidos[];
}
agregarPartido(Partido partido){
  partidos.add(partido);
}
mostrarPartidos(){
  for( partido in partidos){
    print('Local ${Partido.nombreLoc} vs Visitante ${Partido.nombreVis;}' );
  }
}
}