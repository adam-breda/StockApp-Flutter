import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_pages.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  final box = GetStorage();
  var emailUser = "".obs;
  var name = "".obs;
  var role = "".obs;
  var id_user = "".obs;
  List<dynamic> beliPortos = [].obs;
  // List<dynamic> reqAdmin = [].obs;
  List<dynamic> companies = [].obs;
  List<dynamic> requestUser = [].obs;
  final nameC = TextEditingController();
  final idPortofolioBeliC = TextEditingController();
  final idPortofolioJualC = TextEditingController();
  final volumeC = TextEditingController();
  final hargaBeliC = TextEditingController();
  final hargaJualC = TextEditingController();
  final tanggalBeliC = TextEditingController();
  final tanggalJualC = TextEditingController();
  final jenisSahamC = TextEditingController();
  final statusC = TextEditingController();
  // final reqAnalyst = "Analyst";
  // final status = "pending";

  var isLoading = false.obs;
  var isSending = false.obs;
  String? statusReqAdmin;
  var statusReqAdmin1 = "pending";

  List<dynamic> report = [].obs;
  void logout() {
    box.remove("token");
    box.remove('email');
    box.remove('name');
    Get.offAllNamed(Routes.LOGIN);
  }

  Future<void> updateMyProfile(String id) async {
    try {
      isSending.value = true;
      final token = box.read('token');
      print(token);
      //  final dio = Dio();
      // dio.options.headers['Authorization'] = 'Bearer $token';
      final headers = {'Authorization': 'Bearer $token'};

      final response = await http.post(
        Uri.parse('http://env-4734168.user.cloudjkt01.com/api/editProfile'),
        headers: headers,
        body: {
          'id': id,
          'name': nameC.text,
        },
      );
      print("edit nama");
      print(response.body);

      print(response.statusCode);
      if (response.statusCode == 200) {
        isSending.value = false;
        final token = box.read('token');
        print(token);
        //  final dio = Dio();
        // dio.options.headers['Authorization'] = 'Bearer $token';
        final headers = {'Authorization': 'Bearer $token'};

        final response = await http.post(
          Uri.parse('http://env-4734168.user.cloudjkt01.com/api/editProfile'),
          headers: headers,
          body: {
            'id': id,
            'name': nameC.text,
          },
        );
        print("edit nama new");
        print(response.body);
        //fetchJual();
        //PlanManage();
        //name.value;
        Get.back();

        //  PlanManage();
        // Get.back();
        Get.snackbar(
          'Berhasil',
          'Profile berhasil di update',
          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          backgroundColor: Colors.green,
        );
        // Get.snackbar(
        //   priceC.text,
        //   monthC.text,
        //   margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
        //   backgroundColor: Colors.green,
        // );
      }
    } catch (e) {
      isSending.value = false;
      Get.defaultDialog(title: 'Error', middleText: e.toString());
    }
  }

  // Future<void> CheckRequest() async {
  //   try {
  //     print("Fetching request");
  //     isLoading.value = true;
  //     final token = box.read('token');
  //     var apiUrl = 'http://env-4734168.user.cloudjkt01.com/api/checkuser';

  //     final response = await http.get(
  //       Uri.parse(apiUrl),
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       isLoading.value = false;
  //       var result = jsonDecode(response.body)['data']['pending'];
  //       // DateTime tanggal =
  //       //     jsonDecode(response.body)['data']['existing']['expired'];

  //       // Duration difference = tanggal.difference(waktuIni);
  //       // var daysDifference = difference.inDays;
  //       //int differenceInDays = calculateDifferenceInDays(waktuIni, tanggal);
  //       // TanggalSelisih = [daysDifference];
  //       requestUser = result;
  //       print("ini request");
  //       print(requestUser);
  //       // print("ini selisih hari");
  //       // print(daysDifference);
  //     } else {
  //       Get.snackbar('Error', 'Failed to get request ',
  //           margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
  //           snackPosition: SnackPosition.BOTTOM,
  //           backgroundColor: Colors.red,
  //           colorText: Colors.white);
  //     }
  //   } catch (error) {
  //     isLoading.value = false;
  //     Get.snackbar('Error', 'Failed to get request',
  //         margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white);
  //   }
  // }

  Future<void> fetchCompanies() async {
    try {
      isLoading.value = true;
      //trend
      var apiUrl =
          'https://api.goapi.id/v1/stock/idx/trending?api_key=1hzlCQzlW2UqjegV5GFoiS78vaW9tF';

      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        isLoading.value = true;
        var result = jsonDecode(response.body)['data']['results'];
        companies = result;
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

  Future<void> fetchBeli() async {
    try {
      print("Fetching all portos");
      fetchCompanies();

      isLoading.value = false;
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

  // Future<void> requestAdmin() async {
  //   // status
  //   try {
  //     var id = 18;
  //     isSending.value = true;
  //     final token = box.read('token');
  //     print(token);
  //     final dio = Dio();
  //     dio.options.headers['Authorization'] = 'Bearer $token';
  //     final headers = {'Authorization': 'Bearer $token'};

  //     final response = await dio.post(
  //       'http://env-4734168.user.cloudjkt01.com/api/request',
  //       data: {
  //         'user_id': id,
  //         'status': "pending",
  //       },
  //     );
  //     if (response.statusCode == 200) {
  //       isSending.value = false;
  //       //Get.back();
  //       // if (status == 'Analyst') {
  //       //   Get.back();
  //       // } else {
  //       //   Get.back();
  //       // }

  //       Get.snackbar('Berhasil', 'Status pending untuk menjadi analyst',
  //           backgroundColor: Colors.green);
  //     } else {
  //       isSending.value = false;
  //       throw Exception('Failed to request analyst');
  //     }
  //   } catch (e) {
  //     isSending.value = false;
  //     Get.defaultDialog(title: 'Error', middleText: e.toString());
  //   }
  // }

  Future<void> requestAdmin() async {
    // status
    try {
      var id = 18;
      isSending.value = true;
      final token = box.read('token');
      print(token);

      final headers = {'Authorization': 'Bearer $token'};

      final response = await http.post(
        Uri.parse('http://env-4734168.user.cloudjkt01.com/api/request'),
        headers: headers,
        body: {
          'status': "2",
        },
      );
      if (response.statusCode == 200) {
        isSending.value = false;
        Get.back();
        // if (status == 'Analyst') {
        //   Get.back();
        // } else {
        //   Get.back();
        // }

        Get.snackbar('Berhasil', 'Status pending untuk menjadi analyst',
            backgroundColor: Colors.green);
      } else {
        Get.snackbar('Pending', 'Anda sudah request menjadi analyst',
            backgroundColor: Colors.yellow);
        isSending.value = false;
        // throw Exception('');
      }
    } catch (e) {
      isSending.value = false;
      Get.defaultDialog(title: 'Error', middleText: e.toString());
    }
  }

  Future<void> request() async {
    print('a');
    try {
      print("d");
      // Kirim data login ke API menggunakan Dio
      final response = await Dio().post(
        //Jika menggunakan android emulator maka URL API menjadi http://10.0.2.2, bukan http://127.0.0.1
        'http://env-4734168.user.cloudjkt01.com/api/request',
        data: {
          'user_id': 12,
          'status': 2,
          // 'email': emailC.text,
          // 'password': passC.text,
        },
      );
      //  print(response.data);
      print('b');
      if (response.statusCode == 200) {
        // Simpan token ke dalam penyimpanan lokal
        // final token = response.data['access_token'];
        // final statusReqAdmin1 = response.data['data']['status'];
        //final email = response.data['data']['email'];

        //  box.write('name', name);
        box.write('user_id', 12);
        box.write('status', 2);
        print('c');
        // box.write("email", email);
        // box.write('role', 'User');
        // box.write('id_roles', "3");

        Get.snackbar("Register Account Success", "Welcome, " + statusReqAdmin1,
            margin: EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 10),
            backgroundColor: Colors.green[200]);
        // Get.offAllNamed(Routes.HOME);
      } else if (response.statusCode == 401) {
        print('d');
        Get.snackbar('Error', 'Failed to Register',
            margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }

      // await saveToken(token);
    } catch (e) {
      // Jika gagal login, tampilkan pesan kesalahan
      Get.snackbar('Error', 'Failed to Register: $e',
          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 10),
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  Future<void> Report() async {
    try {
      print("Fetching all portos");
      isLoading.value = true;
      final token = box.read('token');
      var apiUrl = 'http://env-4734168.user.cloudjkt01.com/api/report';

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        var result = jsonDecode(response.body)['data'];

        report = result;
        print("ini reportku");
        print(report);

        if (report != null) {
          report = result;
          print("ini reportku");
          print(report);
        } else {
          print("The value is negative");
        }
      } else {
        Get.snackbar('Error', 'Failed to get report profile',
            margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (error) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to get report profile',
          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  // Future<void> NamaUser() async {
  //   try {
  //     print("Fetching user");
  //     isLoading.value = true;
  //     final token = box.read('token');
  //     final id = arguments['id'];
  //     var apiUrl =
  //         'http://env-4734168.user.cloudjkt01.com/api/detailsubscribe/$id';

  //     final response = await http.get(
  //       Uri.parse(apiUrl),
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       isLoading.value = false;
  //       var result = jsonDecode(response.body)['data'];

  //       hargaPilih = result;
  //       print('ini harga pilih');
  //       print(hargaPilih);
  //     }
  //   } catch (error) {
  //     isLoading.value = false;
  //     Get.snackbar('Error', 'Failed to get subs analyst',
  //         margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white);
  //   }
  // }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    Report();
    fetchCompanies();
    fetchBeli();
    // CheckRequest();
    print(box.read("email"));
    emailUser.value = box.read("email");
    name.value = box.read("name");
    role.value = box.read("role");
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
