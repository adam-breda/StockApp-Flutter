import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stock_app/app/routes/app_pages.dart';

class LoginController extends GetxController {
  var hidePass = true.obs;
  var isLoading = false.obs;
  final box = GetStorage();
  // final emailC = TextEditingController();
  // final passC = TextEditingController();
  final emailC = TextEditingController(text: "adam.breda@gmail.com");
  final passC = TextEditingController(text: "ratihandira");

  var isAuthenticated = false.obs;

  Future<void> login() async {
    try {
      // Kirim data login ke API menggunakan Dio

      // String token = "";
      // await FirebaseMessaging.instance.getToken().then((value) {
      //   token = value!;
      // });

      final response = await Dio().post(
        //Jika menggunakan android emulator maka URL API menjadi http://10.0.2.2, bukan http://127.0.0.1
        'http://env-4734168.user.cloudjkt01.com/api/login',
        data: {
          'email': emailC.text,
          'password': passC.text,
          //'fcm_token': token,
        },
      );
      if (response.statusCode == 200) {
        // Simpan token ke dalam penyimpanan lokal
        final token = response.data['access_token'];
        final roles = response.data['role'];
        final id_role = response.data['id_role'];
        final name = response.data['name'];

        box.write('name', name);
        box.write('token', token);
        print("ini token login");
        print(token);
        box.write("email", emailC.text);
        box.write('role', roles);
        box.write('id_role', id_role);

        Get.snackbar("Login Success", response.data['message'],
            margin: EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 10),
            backgroundColor: Colors.green[200]);
        Get.offAllNamed(Routes.HOME);
      } else if (response.statusCode == 401) {
        Get.snackbar('Error', 'Failed to login',
            margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }

      // await saveToken(token);
    } catch (e) {
      // Jika gagal login, tampilkan pesan kesalahan
      Get.snackbar('Error', 'Failed to login, email or password incorrect',
          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 10),
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailC.dispose();
    passC.dispose();
    super.onClose();
  }
}
