import 'package:flutter/material.dart';
import '../model/painting.dart';
import '../service/api_service.dart';

class PaintingsViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Painting> _paintings = [];

  List<Painting> get paintings => _paintings;

  Future<void> loadPaintings() async {
    _paintings = await _apiService.fetchPaintings();
    notifyListeners();
  }
}