import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

import '../../vehicle.dart';

class VehicleEntryScreen extends StatelessWidget {
  final TextEditingController modeloController = TextEditingController();
  final TextEditingController horaEntradaController = TextEditingController();
  final TextEditingController placaController = TextEditingController();
  final TextEditingController nomeClienteController = TextEditingController();
  final TextEditingController telefoneClienteController =
      TextEditingController();
  final Future<Database> database;

  VehicleEntryScreen({required this.database});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Veículo'),
        backgroundColor: Color.fromARGB(255, 15, 41, 125),
      ),
      body: Container(
        color: Color.fromARGB(255, 0, 3, 27),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                width: 350,
                height: 50,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 149, 149, 199),
                  borderRadius: BorderRadius.circular(
                      15.0), // Valor do raio para bordas arredondadas
                ),
                child: TextField(
                  controller: modeloController,
                  decoration: InputDecoration(
                    hintText: 'Modelo:',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.0), // Ajuste o valor conforme necessário
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 350,
                height: 50,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 149, 149, 199),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: TextField(
                  controller: horaEntradaController,
                  decoration: InputDecoration(
                      hintText: 'hora de entrada:',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      enabledBorder: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 350,
                height: 50,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 149, 149, 199),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: TextField(
                  controller: placaController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      hintText: 'Placa:',
                      border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 350,
                height: 50,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 149, 149, 199),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: TextField(
                  controller: nomeClienteController,
                  decoration: InputDecoration(
                    hintText: 'Nome do Cliente',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 350,
                height: 50,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 149, 149, 199),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: TextField(
                  controller: telefoneClienteController,
                  decoration: InputDecoration(
                    hintText: 'Telefone do Cliente',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: 200,
                height: 44,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(
                          255, 15, 41, 125) // Altere para a cor desejada
                      ),
                  onPressed: () {
                    addVehicle(
                      Vehicle(
                        modelo: modeloController.text,
                        horaEntrada: horaEntradaController.text,
                        placa: placaController.text,
                        nomeCliente: nomeClienteController.text,
                        telefoneCliente: telefoneClienteController.text,
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Salvar',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
                  ),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 500, //CONTAINER DE AJUSTE
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addVehicle(Vehicle vehicle) async {
    final Database db = await database;
    await db.insert(
      'vehicles',
      vehicle.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
