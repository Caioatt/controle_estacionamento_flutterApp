import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../../vehicle.dart';
import '../cadastro/cadastrar_veiculo.dart';
import 'dart:async';

class VehicleListScreen extends StatefulWidget {
  final Future<Database> database;

  VehicleListScreen(this.database);

  @override
  _VehicleListScreenState createState() => _VehicleListScreenState();
}

class _VehicleListScreenState extends State<VehicleListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 15, 41, 125),
        title: Text('Controle de Estacionamento'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
            },
          ),
        ],
      ),
      body: Container(
        color: Color.fromARGB(255, 0, 3, 27),
        child: FutureBuilder<List<Vehicle>>(
          future: getVehicles(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            final vehicles = snapshot.data!;
            return ListView.builder(
              itemCount: vehicles.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    'Modelo: ${vehicles[index].modelo}',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    'Placa: ${vehicles[index].placa}',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(
                            255, 15, 41, 125) // Altere para a cor desejada
                        ),
                    onPressed: () {
                      _showVehicleDetails(context, vehicles[index]);
                    },
                    child: Text('Ver Mais'),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 15, 41, 125),
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  VehicleEntryScreen(database: widget.database),
            ),
          );
        },
      ),
    );
  }

  Future<List<Vehicle>> getVehicles() async {
    final Database db = await widget.database;
    final List<Map<String, dynamic>> maps = await db.query('vehicles');
    return List.generate(maps.length, (i) {
      return Vehicle(
        id: maps[i]['id'],
        modelo: maps[i]['modelo'],
        horaEntrada: maps[i]['horaEntrada'],
        placa: maps[i]['placa'],
        nomeCliente: maps[i]['nomeCliente'],
        telefoneCliente: maps[i]['telefoneCliente'],
      );
    });
  }

  void _showVehicleDetails(BuildContext context, Vehicle vehicle) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: AlertDialog(
            elevation: 20,
            backgroundColor: Color.fromARGB(255, 15, 41, 125),
            title: Text(
              'Detalhes do Veículo',
              style: TextStyle(color: Colors.white),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Modelo: ${vehicle.modelo}',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Placa: ${vehicle.placa}',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Hora de Entrada: ${vehicle.horaEntrada}',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Nome do Cliente: ${vehicle.nomeCliente}',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Telefone do Cliente: ${vehicle.telefoneCliente}',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(
                        255, 18, 67, 231) // Altere para a cor desejada
                    ),
                onPressed: () {
                  _deleteVehicle(vehicle);
                  Navigator.of(context).pop();
                },
                child: Text('Veiculo saiu'),
              ),
              SizedBox(
                width: 2,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(
                        255, 18, 67, 231) // Altere para a cor desejada
                    ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Fechar'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _deleteVehicle(Vehicle vehicle) async {
    final Database db = await widget.database;
    await db.delete(
      'vehicles',
      where: "id = ?",
      whereArgs: [vehicle.id],
    );
    setState(() {});
  }
}
