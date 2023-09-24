import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../models/Company.dart';
import '../../../routes/app_pages.dart';

// class Company {
//   String? ticker;
//   String? name;
//   String? logo;

//   Company({this.ticker, this.name, this.logo});

//   Company.fromJson(Map<String, dynamic> json) {
//     ticker = json['ticker'];
//     name = json['name'];
//     logo = json['logo'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['ticker'] = this.ticker;
//     data['name'] = this.name;
//     data['logo'] = this.logo;
//     return data;
//   }
// }

class PostController extends GetxController {
  var isSending = false.obs;
  var isLoading = false.obs;
  final box = GetStorage();
  final titleC = TextEditingController();
  final contentC = TextEditingController();
  var valueTag = 0.obs;
  var namaSahamTag = 0.obs;
  List<dynamic> mine = [].obs;
  String? selectedValueTag;
  String? selectedValueSaham;
  List<Company> namaCompany = [];

  // Future<void> fetchNamaCompany() async {
  //   final String apiUrl = 'http://env-4734168.user.cloudjkt01.com/api';
  //   final dio = Dio();
  //   final box = GetStorage();
  //   final token = box.read('token');
  //   dio.options.headers['Authorization'] = 'Bearer $token';
  //   try {
  //     final response = await dio.get('${apiUrl}/company');

  //     final results = response.data['data'];
  //     List<Company> companyList = List<Company>.from(
  //       results.map((json) => Company.fromJson(json)),
  //     );

  //     namaCompany.assignAll(companyList);
  //     print("jenis saham " + namaCompany.toString());
  //   } catch (e) {
  //     throw Exception('Error: $e');
  //   }
  // }

  Future<void> fetchMinePost() async {
    try {
      print("Fetching all mine post");
      isLoading.value = true;
      final token = box.read('token');
      var apiUrl = 'http://env-4734168.user.cloudjkt01.com/api/post/managee';

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        var result = jsonDecode(response.body)['data'];

        mine = result;
        print('ini mine post');
        print(mine);
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

  Future<void> addPost(String title, String content, String tag) async {
    int nTag = valueTag.value;
    var nTagValue = ["Less Than", "More Than"][nTag];

    if (title == "") {
      Get.snackbar('Perhatian', 'Anda belum mengisi judul',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    if (content == "") {
      Get.snackbar('Perhatian', 'Anda belum mengisi content',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    try {
      isSending.value = true;
      final token = box.read('token');
      print(token);
      final headers = {'Authorization': 'Bearer $token'};
      final response = await http.post(
        Uri.parse('http://env-4734168.user.cloudjkt01.com/api/post/add'),
        headers: headers,
        body: {
          'title': title,
          'content': content,
          'tag': selectedValueTag,
          // 'id_saham': selectedValueSaham,
        },
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        isSending.value = false;
        Get.back();
        //Get.back();
        // fetchMinePost();

        Get.toNamed(Routes.HOME);
        fetchMinePost();

        print('Response status : ${response.statusCode}');
        print('Response body : ${response.body}');
        Get.snackbar(
          'Berhasil',
          'Data berhasil di tambah',
          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          backgroundColor: Colors.green,
        );
      } else {
        isSending.value = false;
        Get.defaultDialog(title: 'Error', middleText: 'Gagal tambah data');
      }
    } catch (e) {
      isSending.value = false;
      print("ini error");
      Get.defaultDialog(title: 'Error', middleText: e.toString());
    }
  }

  void showDialog(String title, String content) {
    String _valTag; //Ini untuk menyimpan value data gender

    List _tag = ["public", "private"];
    Get.defaultDialog(
        title: " POST ",
        titlePadding: EdgeInsets.all(5),
        content: Padding(
          padding: EdgeInsets.all(5),
          child: Container(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("title"),
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                  ),
                  child: TextField(
                    controller: titleC,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(fontSize: 13.0),
                      hintText: 'Masukkan title',
                      hintStyle: TextStyle(fontSize: 11.0),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("content"),
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                  ),
                  child: TextField(
                    controller: contentC,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(fontSize: 13.0),
                      hintText: 'Masukkan title',
                      hintStyle: TextStyle(fontSize: 11.0),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12.0),
                    ),
                  ),
                ),
                Obx(() => Container(
                    width: Get.width,
                    child: isSending.value == false
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(200, 40),
                                backgroundColor: Colors.redAccent[400]),
                            onPressed: () {
                              // addPost(title, content, tag);
                            },
                            child: Text("Simpan"))
                        : Center(
                            child: CircularProgressIndicator(),
                          )))
              ],
            ),
          ),
        ));
  }

  @override
  void onInit() {
    super.onInit();
    fetchMinePost();
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
