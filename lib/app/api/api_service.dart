import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:stock_app/app/models/Company.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:stock_app/app/models/JenisSaham.dart';
import 'package:stock_app/app/models/PaymentChannel.dart';
import 'package:stock_app/app/models/Tagihan.dart';
import '../models/Sekuritas.dart';
import '../models/Subscribe.dart';

class ApiService {
  static var client = http.Client();
  final String apiUrl = 'http://env-4734168.user.cloudjkt01.com/api';
  final dio = Dio();
  final box = GetStorage();

  Future<List<Tagihan>> fetchTagihan(String status) async {
    try {
      final token = box.read('token');
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio.post(
        'http://env-4734168.user.cloudjkt01.com/api/portofolio/tagihan',
        data: {'status': status},
      );

      // print(response.data['data']);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];

        return data.map((item) => Tagihan.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load portofolio');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Tagihan>> fetchSubscription(String status) async {
    try {
      final token = box.read('token');
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio.post(
        'http://env-4734168.user.cloudjkt01.com/api/history/subscribe',
        data: {'status': status},
      );

      // print(response.data['data']);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];

        return data.map((item) => Tagihan.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load portofolio');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Subscribe>> fetchSubs(String status) async {
    try {
      final token = box.read('token');
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio.post(
        'http://env-4734168.user.cloudjkt01.com/api/notifsubs',
        data: {'status': status},
      );

      // print(response.data['data']);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];

        return data.map((item) => Subscribe.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load portofolio');
      }
    } catch (e) {
      print("ini error");
      print(e);
      throw Exception('Error: $e');
    }
  }

  Future<List<Sekuritas>> fetchSekuritas() async {
    final token = box.read('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      final response = await dio.get('${apiUrl}/portofolio/sekuritas');
      print(response.data['data']);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        print(data);

        return data.map((item) => Sekuritas.fromJson(item)).toList();
      } else {
        throw Exception('Failed to fetch sekuritas');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<JenisSaham>> fetchJenisSaham() async {
    final token = box.read('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      final response = await dio.get('${apiUrl}/portofolio/jenis');
      print("jenis saham " + response.data['data']);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        print(data);

        return data.map((item) => JenisSaham.fromJson(item)).toList();
      } else {
        throw Exception('Failed to fetch jenis saham');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<String> payTagihan(int id_tagihan, String metode_pembayaran) async {
    try {
      final token = box.read('token');
      dio.options.headers['Authorization'] = 'Bearer $token';
      print({'id_tagihan': id_tagihan, 'metode_pembayaran': metode_pembayaran});
      final response = await dio.post(
        'http://env-4734168.user.cloudjkt01.com/api/portofolio/paytagihan',
        data: {
          'id_tagihan': id_tagihan,
          'metode_pembayaran': metode_pembayaran
        },
      );

      print(response.data);

      if (response.statusCode == 200) {
        String status = response.data['message'];
        return status;
      } else {
        throw Exception('Failed to load portofolio');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<PaymentChannel>> fetchPayment() async {
    final token = box.read('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      final response = await dio.get('${apiUrl}/portofolio/paymentchannel');
      print(response.data['data']);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];

        return data.map((item) => PaymentChannel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to fetch sekuritas');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<List<Company>?> fetchCompany() async {
    final response = await http.get(Uri.parse(
        'https://api.goapi.id/v1/stock/idx/companies?api_key=1hzlCQzlW2UqjegV5GFoiS78vaW9tF'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data']['results'];
    }
    return null;
  }
}
