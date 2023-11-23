import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:local_auth/local_auth.dart';
import 'package:controle_estacionamento/app/views/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<Database> database;
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  MyApp() : database = initializeDatabase();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Database>(
      future: database,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            home: SplashScreen(database, _localAuthentication),
          );
        } else {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  final Future<Database> database;
  final LocalAuthentication localAuthentication;

  SplashScreen(this.database, this.localAuthentication);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'lib/assets/imgs/background.jpg'), 
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 80,
              ),
              
              Image.asset(
                'lib/assets/imgs/logo1.png',
                height: 200,
              ),
              SizedBox(height: 70),
              Container(
                width: 115,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    //  backgroundColor: Colors.indigo,
                    primary: Color.fromARGB(255, 15, 41, 125),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  onPressed: () async {
                    bool isAuthenticated = await authenticate();
                    if (isAuthenticated) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VehicleListScreen(database),
                        ),
                      );
                    } else {
                      // Autenticação falhou
                      print('falha na autenticação');
                    }
                  },
                  child: Text(
                    'Entrar',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await localAuthentication.authenticate(
        options: AuthenticationOptions(),
        localizedReason: 'Autentique-se para acessar o aplicativo',
      );
    } catch (e) {
      print(e);
    }
    return authenticated;
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
