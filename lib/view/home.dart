import 'package:flutter/material.dart';
import 'paintings_list_screen.dart'; // Asegúrate de importar tu pantalla

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio del Recorrido'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Aquí comienza tu recorrido por el Centro Cultural UNSA.',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaintingsListScreen()),
                );
              },
              child: Text('Ver obras'),
            ),
          ],
        ),
      ),
    );
  }
}
