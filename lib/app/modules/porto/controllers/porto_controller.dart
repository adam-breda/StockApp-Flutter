import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class PortoController extends GetxController {
  final selectedType = "semua".obs;
  final idPortofolioBeliC = TextEditingController();
  final idPortofolioJualC = TextEditingController();
  final volumeC = TextEditingController();
  final hargaBeliC = TextEditingController();
  final hargaJualC = TextEditingController();
  final tanggalBeliC = TextEditingController();
  final tanggalJualC = TextEditingController();
  final jenisSahamC = TextEditingController();
  final sekuritasC = TextEditingController();
  //final Map arguments = Get.arguments;
  //final feeC = TextEditingController();
  final box = GetStorage();
  //final Map arguments = Get.arguments;
  List<dynamic> DetailPorto = [].obs;
  var isLoading = false.obs;
  var isSending = false.obs;
  var untungsemua = 0;
  //final Map arguments = Get.arguments;

  List<dynamic> allPortos = [].obs;
  List<dynamic> detailAllPortos = [].obs;
  List<dynamic> beliPortos = [].obs;
  List<dynamic> jualPortos = [].obs;
  List<dynamic> PortoSemua = [].obs;
  List<dynamic> TotalKeuntungan = [].obs;
  List<dynamic> portos = [].obs;
  List<dynamic> report = [].obs;
  List<dynamic> companies = [].obs;
  List<dynamic> gabung = [].obs;
  RxList<Map<String, dynamic>> dataAllPorto = <Map<String, dynamic>>[].obs;
  String? selectedValueSekuritas;
  String? selectedValueCardSekuritas;
  //final selectedValueCardSekuritas = TextEditingController();
  //String? donekeuntungan;
  // List<dynamic> donekeuntungan = [].obs;
  String? ayam;

  Future<void> Report() async {
    try {
      print("Fetching all report");
      isLoading.value = true;
      final token = box.read('token');
      var apiUrl = 'http://env-4734168.user.cloudjkt01.com/api/this/year';

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        isLoading.value = false;
        var result = jsonDecode(response.body)['data'];

        report = result;
        print("ini report");
        print("api report " + apiUrl);
        print(report);
      } else {
        // print(Error);
        // Get.snackbar('Error', 'Failed to get report profile1',
        //     margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
        //     snackPosition: SnackPosition.BOTTOM,
        //     backgroundColor: Colors.red,
        //     colorText: Colors.white);
      }
    } catch (e) {
      isLoading.value = false;
      //print(error);

      Get.snackbar('Error', 'Failed to get report profile',
          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      throw Exception('Error: $e');
    }
  }

  // void fetchDetailSaham() async {
  //   print("Fetching news");

  //   try {
  //     isLoading.value = true;
  //     final nama = arguments['nama_saham'];
  //     print("judul isi berita: " + nama);
  //     print("coba aja mau aoa engga");
  //     final response = await http
  //         .get(Uri.parse('http://env-4734168.user.cloudjkt01.com/api/portosemuaa$nama'));

  //     if (response.statusCode == 200) {
  //       isLoading.value = false;
  //       final jsonString = response.body;
  //       final parsedJson = jsonDecode(jsonString);
  //       final resultnews = parsedJson['data'];

  //       detailAllPortos = resultnews;
  //       print("news ini: " + resultnews);
  //     } else {
  //       throw Exception('Failed to load news');
  //     }
  //   } catch (error) {
  //     isLoading.value = false;
  //     print(error);
  //   }
  // }

  Future<void> saveTransaction(String id_portofolio) async {
    try {
      isSending.value = true;
      final token = box.read('token');
      print(token);
      final dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio.post(
        'http://env-4734168.user.cloudjkt01.com/api/portofolio/edit',
        data: {
          'id_portofolio': id_portofolio,
          'volume': int.parse(volumeC.text),
          //'fee': int.parse(feeC.text)
        },
      );
      if (response.statusCode == 200) {
        isSending.value = false;
        Get.back();
        Get.back();
        selectedType('semua');
        fetchPorto('');
        Get.snackbar('Berhasil', 'Data berhasil di update',
            margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            backgroundColor: Colors.green);
      } else {
        isSending.value = false;
        Get.defaultDialog(title: 'Error', middleText: 'Gagal update data');
      }
    } catch (e) {
      isSending.value = false;
      Get.defaultDialog(title: 'Error', middleText: 'Gagal update data');
    }
  }

  Future<void> deleteJual(int id_portofolio) async {
    try {
      isSending.value = true;
      final token = box.read('token');
      print(token);
      final dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio.get(
          'http://env-4734168.user.cloudjkt01.com/api/portofoliojual/delete/$id_portofolio');
      if (response.statusCode == 200) {
        isSending.value = false;
        Get.back();
        Get.back();
        selectedType('semua');
        fetchBeli();
        Get.snackbar('Berhasil', 'Data berhasil di delete',
            backgroundColor: Colors.green);
      } else {
        isSending.value = false;
        Get.defaultDialog(title: 'Error', middleText: 'Gagal delete data');
      }
    } catch (e) {
      print(e);
      isSending.value = false;
      Get.defaultDialog(title: 'Error', middleText: 'Gagal delete data');
    }
  }

  Future<void> deleteBeli(int id_portofolio) async {
    try {
      isSending.value = true;
      final token = box.read('token');
      print(token);
      final dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio.get(
          'http://env-4734168.user.cloudjkt01.com/api/portofoliobeli/delete/$id_portofolio');
      if (response.statusCode == 200) {
        isSending.value = false;
        Get.back();
        Get.back();
        selectedType('semua');
        fetchBeli();
        print("ini beli porto");
        print(beliPortos);
        Get.snackbar('Berhasil', 'Data berhasil di delete',
            backgroundColor: Colors.green);
      } else {
        isSending.value = false;
        Get.defaultDialog(title: 'Error', middleText: 'Gagal delete data');
      }
    } catch (e) {
      print(e);
      isSending.value = false;
      Get.defaultDialog(title: 'Error', middleText: 'Gagal delete data');
    }
  }

  void selectType(String type) {
    print(type);
    selectedType.value = type;
    fetchPorto(type);
  }

  Future<void> fetchJual() async {
    try {
      print("Fetching all portos");
      isLoading.value = true;
      final token = box.read('token');
      var apiUrl = 'http://env-4734168.user.cloudjkt01.com/api/portofoliojual';

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        var result = jsonDecode(response.body)['data'];

        jualPortos = result;
        print("ini jual porto");
        print(jualPortos);
      }
    } catch (error) {
      isLoading.value = false;
      // Get.snackbar('Error', 'Failed to get porto jual',
      //     margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
      //     snackPosition: SnackPosition.BOTTOM,
      //     backgroundColor: Colors.red,
      //     colorText: Colors.white);
    }
  }

  Future<void> fetchBeli() async {
    try {
      print("Fetching all portos");
      fetchCompanies();

      isLoading.value = true;
      final token = box.read('token');
      var apiUrl = 'http://env-4734168.user.cloudjkt01.com/api/portofoliobeli';

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        var result = jsonDecode(response.body)['data'];

        beliPortos = result;
        print("ini beli porto");
        print(beliPortos);
      }
    } catch (error) {
      isLoading.value = false;
      // Get.snackbar('Error', 'Failed to get all portos',
      //     margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
      //     snackPosition: SnackPosition.BOTTOM,
      //     backgroundColor: Colors.red,
      //     colorText: Colors.white);
    }
  }

  Future<void> updateDataJual(String id_portofolio_jual) async {
    try {
      isSending.value = true;
      final token = box.read('token');
      print(token);
      final dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.post(
        'http://env-4734168.user.cloudjkt01.com/api/portofolio/editJual',
        data: {
          'id_portofolio_jual': id_portofolio_jual,
          'volume': int.parse(volumeC.text).toString(),
          'harga_jual': int.parse(hargaBeliC.text).toString(),
          'tanggal_beli': tanggalBeliC.text,
        },
      );
      if (response.statusCode == 200) {
        isSending.value = false;
        fetchJual();
        Get.back();
        Get.back();
      }
    } catch (e) {
      isSending.value = false;
      Get.defaultDialog(title: 'Error', middleText: e.toString());
    }
  }

  // Future<void> updateDataBeli(String id_portofolio_beli) async {
  //   try {
  //     isSending.value = true;
  //     final token = box.read('token');
  //     print(token);
  //     final dio = Dio();
  //     dio.options.headers['Authorization'] = 'Bearer $token';

  //     final response = await dio.post(
  //       'http://env-4734168.user.cloudjkt01.com/api/portofolio/editBeli',
  //       data: {
  //         'id_portofolio_beli': id_portofolio_beli,
  //         'volume': int.parse(volumeC.text).toString(),
  //         'harga_beli': int.parse(hargaBeliC.text).toString(),
  //         'tanggal_beli': tanggalBeliC.text,
  //       },
  //     );
  //     if (response.statusCode == 200) {
  //       isSending.value = false;
  //       fetchBeli();
  //       Get.back();
  //       Get.back();
  //     }
  //   } catch (e) {
  //     isSending.value = false;
  //     Get.defaultDialog(title: 'Error', middleText: e.toString());
  //   }
  // }

  Future<void> saveTransactionBeli(String id_portofolio_beli) async {
    // print(jenisSahamC.text);
    try {
      isSending.value = true;
      final token = box.read('token');
      print(token);
      final headers = {'Authorization': 'Bearer $token'};
      final response = await http.post(
        Uri.parse(
            'http://env-4734168.user.cloudjkt01.com/api/portofolio/editbeli'),
        headers: headers,
        body: {
          'id_portofolio_beli': id_portofolio_beli,
          'volume': int.parse(volumeC.text).toString(),
          'harga_beli': int.parse(hargaBeliC.text).toString(),
          'tanggal_beli': tanggalBeliC.text,
          'id_sekuritas': selectedValueSekuritas,
        },
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        isSending.value = false;
        Get.back();
        Get.back();
        // selectedType('beli');
        fetchBeli();
        Get.snackbar(
          'Berhasil',
          'Data berhasil di update',
          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          backgroundColor: Colors.green,
        );
      } else {
        isSending.value = false;
        Get.defaultDialog(title: 'Error', middleText: 'Gagal update data');
      }
    } catch (e) {
      isSending.value = false;
      Get.defaultDialog(title: 'Error', middleText: e.toString());
    }
  }

  Future<void> saveTransactionJual(String id_portofolio_jual) async {
    // print(jenisSahamC.text);
    try {
      isSending.value = true;
      final token = box.read('token');
      print(token);
      final headers = {'Authorization': 'Bearer $token'};
      final response = await http.post(
        Uri.parse(
            'http://env-4734168.user.cloudjkt01.com/api/portofolio/editjual'),
        headers: headers,
        body: {
          'id_portofolio_jual': id_portofolio_jual,
          'volume': int.parse(volumeC.text).toString(),
          'harga_jual': int.parse(hargaJualC.text).toString(),
          'tanggal_jual': tanggalJualC.text,
          'id_sekuritas': selectedValueSekuritas,
        },
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        isSending.value = false;
        Get.back();
        Get.back();
        // selectedType('beli');
        fetchJual();
        Get.snackbar(
          'Berhasil',
          'Data berhasil di update',
          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          backgroundColor: Colors.green,
        );
      } else {
        isSending.value = false;
        Get.defaultDialog(title: 'Error', middleText: 'Gagal update data');
      }
    } catch (e) {
      isSending.value = false;
      Get.defaultDialog(title: 'Error', middleText: e.toString());
    }
  }

  Future<void> fetchAllPortos() async {
    try {
      print("Fetching all portos");
      isLoading.value = true;
      final token = box.read('token');
      var apiUrl = 'http://env-4734168.user.cloudjkt01.com/api/portofolio';

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        var result = jsonDecode(response.body)['data'];

        allPortos = result;
      }
    } catch (error) {
      isLoading.value = false;
      // Get.snackbar('Error', 'Failed to get portos',
      //     margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
      //     snackPosition: SnackPosition.BOTTOM,
      //     backgroundColor: Colors.red,
      //     colorText: Colors.white);
    }
  }

  Future<void> fetchPorto(String typeName) async {
    try {
      isLoading.value = true;
      final token = box.read('token');

      final dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio.post(
        'http://env-4734168.user.cloudjkt01.com/api/portofolio',
      );
      if (response.statusCode == 200) {
        final data = response.data['data'];
        portos = data;
        isLoading.value = false;
        print(portos);
      }
    } catch (error) {
      isLoading.value = false;
      print(error);
    }
  }

  Future<void> fetchPortoSemua() async {
    try {
      print("Fetching all portos");
      isLoading.value = true;
      //final reportdetail = arguments['year'];
      final token = box.read('token');
      var apiUrl = 'http://env-4734168.user.cloudjkt01.com/api/porto/semua';
      // var apiUrl = 'http://env-4734168.user.cloudjkt01.com/api/portosemua$reportdetail';

      // final token = box.read('token');
      // var apiUrl = 'http://env-4734168.user.cloudjkt01.com/api/portosemua';

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        var result = jsonDecode(response.body)['data'];
        // var totalkeuntunganfinal = jsonDecode(response.body)['data']['index'];

        // var coba = jsonDecode(response.body)['data'];

        // num keuntungan = 0;
        // for (var data in result) {
        //   keuntungan += data['keuntungan'];
        // }

        // print('keuntungan nilai: $keuntungan');

        PortoSemua = result;
        print("ini porto semua");
        print(PortoSemua);

        // TotalKeuntungan = result;

        // num totalkeuntungan = 0;
        // for (var data in TotalKeuntungan) {
        //   totalkeuntungan += data['keuntungan'];
        // }

        // print('keuntungan nilai: $totalkeuntungan');

        // String untunk = totalkeuntungan.toString();
        // print('keuntungan nilai string: $untunk');
        // ayam = untunk.toString();
        // print('keuntungan nilai` ayam: $ayam');

        // List<dynamic> list = [totalkeuntungan];
        // donekeuntungan.add(list);
        // print('done nilai');
        // print(list);
        // donekeuntungan = [totalkeuntungan];
        // var untunk = totalkeuntungan;
        //untungsemua = untunk{0};

        // String jsonString = json.encode(result);
        // // List<Map<String, dynamic>> jsonData = jsonDecode(response.body)['data'];
        // List<Map<String, dynamic>> jsonData = json.decode(jsonString);
      } else {
        print(Error);
        Get.snackbar('Error', 'Failed to get porto semua',
            margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (error) {
      print(Error);
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to get porto semua',
          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  Future<void> fetchCompanies() async {
    try {
      isLoading.value = true;
      //trend
      var apiUrl =
          'https://api.goapi.id/v1/stock/idx/trending?api_key=1hzlCQzlW2UqjegV5GFoiS78vaW9tF';

      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        isLoading.value = false;
        var result = jsonDecode(response.body)['data']['results'];
        companies = result;
        print("ini harga close");
        print(companies);
        // print(c);
      } else {
        Get.snackbar('Error', 'Failed to get trending',
            margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (error) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to get trending',
          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  // Future<void> fetchPortoDetail() async {
  //   try {
  //     print("Fetching porto detail");
  //     isLoading.value = true;
  //     final emitence = arguments['nama_saham'];
  //     final token = box.read('token');
  //     var apiUrl = 'http://env-4734168.user.cloudjkt01.com/api/portosemuaa$emitence';
  //     // var apiUrl = 'http://env-4734168.user.cloudjkt01.com/api/portosemua$reportdetail';

  //     // final token = box.read('token');
  //     // var apiUrl = 'http://env-4734168.user.cloudjkt01.com/api/portosemua';

  //     final response = await http.get(
  //       Uri.parse(apiUrl),
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       isLoading.value = false;
  //       var result = jsonDecode(response.body)['data'];

  //       DetailPorto = result;
  //       print("ini porto detail");
  //       print(DetailPorto);
  //     } else {
  //       print("porto detail error");
  //       Get.snackbar('Error', 'Failed to get porto detail',
  //           margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
  //           snackPosition: SnackPosition.BOTTOM,
  //           backgroundColor: Colors.red,
  //           colorText: Colors.white);
  //     }
  //   } catch (error) {
  //     isLoading.value = false;
  //     Get.snackbar('Error', 'Failed to get porto detail',
  //         margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white);
  //   }
  // }

  @override
  void onInit() async {
    super.onInit();
    // fetchPorto('');
    fetchAllPortos();
    fetchBeli();
    fetchJual();
    fetchPortoSemua();
    Report();
    print("ini fetch companies");
    fetchCompanies();
    //fetchPortoDetail();
    //saveTransactionBeli();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
