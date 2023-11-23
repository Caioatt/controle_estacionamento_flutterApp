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
        title: Text(
          'Cadastrar Veículo',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 15, 41, 125),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color.fromARGB(255, 0, 3, 27),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Image.asset(
                  'lib/assets/imgs/logo1.png', 

                  height: 170,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: 350,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 230, 230, 230),
                    borderRadius: BorderRadius.circular(
                        15.0), 
                  ),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: modeloController,
                    decoration: InputDecoration(
                      hintText: 'Modelo:',
                      hintStyle: TextStyle(fontWeight: FontWeight.w700),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal:
                              16.0), 
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
                    color: const Color.fromARGB(255, 230, 230, 230),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.numberWithOptions(signed: true),
                    controller: horaEntradaController,
                    decoration: InputDecoration(
                        hintText: 'Hora de entrada:',
                        hintStyle: TextStyle(fontWeight: FontWeight.w700),
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
                    color: const Color.fromARGB(255, 230, 230, 230),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: placaController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                        hintText: 'Placa:',
                        hintStyle: TextStyle(fontWeight: FontWeight.w700),
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
                    color: const Color.fromARGB(255, 230, 230, 230),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.name,
                    controller: nomeClienteController,
                    decoration: InputDecoration(
                      hintText: 'Nome do Cliente:',
                      hintStyle: TextStyle(fontWeight: FontWeight.w700),
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
                    color: const Color.fromARGB(255, 230, 230, 230),
                    // color: Color.fromARGB(255, 149, 149, 199),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    controller: telefoneClienteController,
                    decoration: InputDecoration(
                      hintText: 'Telefone do Cliente:',
                      hintStyle: TextStyle(fontWeight: FontWeight.w700),
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
                            255, 15, 41, 125) 
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
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                          color: Colors.white),
                    ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 500, //CONTAINER DE AJUSTE
                    )
                  ],
                ),
                SizedBox(
                  height: 220,
                ),
              ],
            ),
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
