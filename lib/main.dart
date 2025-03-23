import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contador de Pasos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _pasos = 0;
  int _metaDiaria = 0;
  TextEditingController _metaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contador de Pasos'),
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
              ),
              keyboardType: TextInputType.number,
              onSubmitted: (value) {
                setState(() {
                  _metaDiaria = int.tryParse(value) ?? 0;
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'Pasos: $_pasos',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            LinearProgressIndicator(
              value: _metaDiaria > 0 ? _pasos / _metaDiaria : 0,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(
                _pasos >= _metaDiaria ? Colors.green : Colors.blue,
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
                    });
                  },
                  child: Text('Sumar Paso'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (_pasos > 0) _pasos--;
                    });
                  },
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
              child: Text('Reiniciar Contador'),
            ),
          ],
        ),
      ),
    );
  }
}