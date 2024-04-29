import 'dart:convert';
import 'dart:io';
import "package:http/http.dart" as http;
import 'partido.dart';

void main() {
  Partido().obtenerpartidostemporada();
}
