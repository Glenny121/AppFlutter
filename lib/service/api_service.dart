import 'package:dio/dio.dart';
import '../model/painting.dart';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  final Dio _dio;

  ApiService()
      : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: const Duration(seconds: 5),
            receiveTimeout: const Duration(seconds: 5),
            headers: {
              'Content-Type': 'application/json',
            },
          ),
        ) {
    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        responseBody: false,
        requestBody: false,
        responseHeader: false,
      ),
    );
  }

  Future<List<Painting>> fetchPaintings() async {
    try {
      final response = await _dio.get('/posts');

      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> data = response.data;
        return data.map((json) => Painting.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar los datos: Código ${response.statusCode}');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        throw Exception('Error en la respuesta [${e.response!.statusCode}]: ${e.response!.statusMessage}');
      } else {
        throw Exception('❗ Error inesperado: ${e.message}');
      }
    }
  }
}
