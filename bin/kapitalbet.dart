import 'Database.dart';

import 'App.dart';

void main() async {
  await Database().instalacion();
  App().insertarMenu();
}
