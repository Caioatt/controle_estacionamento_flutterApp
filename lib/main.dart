import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:teste_estacionamento/app/views/home/home_screen.dart';
import 'dart:async';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<Database> database;

  MyApp() : database = initializeDatabase();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Database>(
      future: database,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            home: VehicleListScreen(database),
          );
        } else {
          return CircularProgressIndicator(); 
        }
      },
    );
  }
}

Future<Database> initializeDatabase() async {
  return openDatabase(
    join(await getDatabasesPath(), 'vehicles_database.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE vehicles(id INTEGER PRIMARY KEY AUTOINCREMENT, modelo TEXT, horaEntrada TEXT, placa TEXT, nomeCliente TEXT, telefoneCliente TEXT)",
      );
    },
    version: 1,
  );
}
