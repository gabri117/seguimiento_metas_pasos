import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CONTADOR DE PASOS',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.blue,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.green),
        scaffoldBackgroundColor: Colors.grey[900],
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontFamily: 'RobotMono', fontSize: 16),
          bodyMedium: TextStyle(fontFamily: 'RobotMono', fontSize: 14),
          titleLarge: TextStyle(fontFamily: 'RobotMono', fontSize: 24),
        ),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _pasos = 0;
  int _metaDiaria = 0;
  final TextEditingController _metaController = TextEditingController();

  void _mostrarMensajeMetaCumplida(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('¡Felicitaciones! Has alcanzado tu meta de pasos.'),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CONTADOR DE PASOS',
          style: TextStyle(fontFamily: 'RobotMono'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _metaController,
              decoration: InputDecoration(
                labelText: 'Meta Diaria de Pasos',
                labelStyle: TextStyle(color: Colors.blue),
                border: OutlineInputBorder(),
                errorText: _metaDiaria < 0 ? 'La meta no puede ser negativa' : null,
              ),
              keyboardType: TextInputType.number,
              onSubmitted: (value) {
                final meta = int.tryParse(value) ?? 0;
                if (meta >= 0) {
                  setState(() {
                    _metaDiaria = meta;
                  });
                } else {
                  setState(() {
                    _metaDiaria = 0; // Evitar valores negativos
                  });
                }
              },
            ),
            SizedBox(height: 20),
            Text(
              'Pasos: $_pasos',
              style: TextStyle(
                fontFamily: 'RobotMono',
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(10),
              ),
              child: LinearProgressIndicator(
                value: _metaDiaria > 0 ? _pasos / _metaDiaria : 0,
                backgroundColor: Colors.grey[700],
                valueColor: AlwaysStoppedAnimation<Color>(
                  _pasos >= _metaDiaria ? Colors.green : Colors.blue,
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _pasos++;
                      if (_metaDiaria > 0 && _pasos >= _metaDiaria) {
                        _mostrarMensajeMetaCumplida(context);
                      }
                    });
                  },
                  icon: Icon(Icons.add), // Icono de "Sumar"
                  label: Text('Sumar Paso'), // Texto del botón
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      if (_pasos > 0) _pasos--;
                    });
                  },
                  icon: Icon(Icons.remove), // Icono de "Restar"
                  label: Text('Restar Paso'), // Texto del botón
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _pasos = 0;
                });
              },
              icon: Icon(Icons.refresh), // Icono de "Reiniciar"
              label: Text('Reiniciar Contador'), // Texto del botón
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[700],
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}