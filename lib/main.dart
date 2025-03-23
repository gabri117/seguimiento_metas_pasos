import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contador de Pasos',
      theme: ThemeData.dark(), // Modo oscuro
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
        title: Text('CONTADOR DE PASOS'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _metaController,
              decoration: InputDecoration(
                labelText: 'Meta Diaria de Pasos',
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
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[800], // Fondo más oscuro
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
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _pasos++;
                      if (_metaDiaria > 0 && _pasos >= _metaDiaria) {
                        _mostrarMensajeMetaCumplida(context);
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Color de fondo
                    foregroundColor: Colors.white, // Color del texto
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Bordes redondeados
                    ),
                  ),
                  child: Text('Sumar Paso'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (_pasos > 0) _pasos--;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Color de fondo
                    foregroundColor: Colors.white, // Color del texto
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Bordes redondeados
                    ),
                  ),
                  child: Text('Restar Paso'),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _pasos = 0;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[700], // Color de fondo
                foregroundColor: Colors.white, // Color del texto
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Bordes redondeados
                ),
              ),
              child: Text('Reiniciar Contador'),
            ),
          ],
        ),
      ),
    );
  }
}