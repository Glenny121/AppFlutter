import 'package:flutter/material.dart';
import '../model/painting.dart';
import '../viewmodel/paintings_viewmodel.dart';

class PaintingsListScreen extends StatefulWidget {
  @override
  _PaintingsListScreenState createState() => _PaintingsListScreenState();
}

class _PaintingsListScreenState extends State<PaintingsListScreen> {
  final PaintingsViewModel viewModel = PaintingsViewModel();
  List<Painting> filteredPaintings = [];
  String searchQuery = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPaintings();
  }

  Future<void> _loadPaintings() async {
    try {
      await viewModel.loadPaintings();
      setState(() {
        filteredPaintings = viewModel.paintings;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      _showErrorDialog('Error al cargar las publicaciones: $e');
    }
  }

  void updateSearch(String query) {
    setState(() {
      searchQuery = query;
      filteredPaintings = viewModel.paintings.where((p) {
        return p.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void filterDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Filtrar'),
        content: Text('Aquí puedes agregar filtros personalizados.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Publicaciones'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: updateSearch,
                    decoration: InputDecoration(
                      labelText: 'Buscar por título',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                IconButton(
                  onPressed: filterDialog,
                  icon: Icon(Icons.filter_list),
                  tooltip: 'Filtrar',
                ),
              ],
            ),
            SizedBox(height: 12),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : filteredPaintings.isEmpty
                      ? Center(child: Text('No se encontraron publicaciones'))
                      : ListView.builder(
                          itemCount: filteredPaintings.length,
                          itemBuilder: (context, index) {
                            final painting = filteredPaintings[index];
                            return Card(
                              margin: EdgeInsets.symmetric(vertical: 6),
                              child: ListTile(
                                title: Text(painting.title),
                                subtitle: Text(
                                  painting.body,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
