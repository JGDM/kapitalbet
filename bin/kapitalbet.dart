import 'dart:convert';
import 'dart:io';
import "package:http/http.dart" as http;

main() {
  obtenertpartidostemporada();
}

obtenertpartidostemporada() async {
  var headers = {
    'x-rapidapi-key': '906c644d50b216417ceedc1f2248a1b7',
    'x-rapidapi-host': 'v3.football.api-sports.io'
  };
  var request = http.Request(
      'GET', Uri.parse('https://v3.football.api-sports.io/leagues'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}
