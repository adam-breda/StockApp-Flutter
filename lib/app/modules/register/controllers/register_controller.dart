import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_pages.dart';

class RegisterController extends GetxController {
  var hidePass = true.obs;
  var isLoading = false.obs;
  final box = GetStorage();
  final emailC = TextEditingController();
  final passC = TextEditingController();
  final nameC = TextEditingController();

  Future<void> register() async {
    if (nameC.text == "") {
      Get.snackbar('Perhatian', 'Anda belum mengisi nama',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    if (emailC.text == "") {
      Get.snackbar('Perhatian', 'Anda belum mengisi email',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    // if (emailC.text == final email) {
    //   Get.snackbar('Perhatian', 'Anda belum mengisi email',
    //       backgroundColor: Colors.red, colorText: Colors.white);
    //   return;
    // }
    if (passC.text == "") {
      Get.snackbar('Perhatian', 'Anda belum mengisi password',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    try {
      // Kirim data login ke API menggunakan Dio
      final response = await Dio().post(
        //Jika menggunakan android emulator maka URL API menjadi http://10.0.2.2, bukan http://127.0.0.1
        'http://env-4734168.user.cloudjkt01.com/api/register',
        data: {
          'name': nameC.text,
          'email': emailC.text,
          'password': passC.text,
        },
      );
      print(response.data);
      if (response.statusCode == 200) {
        // Simpan token ke dalam penyimpanan lokal
        final token = response.data['access_token'];
        final name = response.data['data']['name'];
        final email = response.data['data']['email'];

        box.write('name', name);
        box.write("token", token);
        box.write("email", email);
        box.write('role', 'User');
        box.write('id_roles', "3");

        Get.snackbar("Register Account Success", "Welcome, " + name,
            margin: EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 10),
            backgroundColor: Colors.green[200]);
        Get.offAllNamed(Routes.HOME);
      } else if (response.statusCode == 401) {
        Get.snackbar('Error', 'Failed to Register',
            margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }

      // await saveToken(token);
    } catch (e) {
      // Jika gagal login, tampilkan pesan kesalahan
      Get.snackbar('Error', 'Email sudah digunakan',
          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 10),
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  @override
  void onInit() {
    super.onInit();
    // print(box.read("email"));
    // emailC.value = box.read("email");
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
