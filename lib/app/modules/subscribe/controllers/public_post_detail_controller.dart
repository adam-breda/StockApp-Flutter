import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class PublicPostDetailController extends GetxController {
  final Map arguments = Get.arguments;
  final box = GetStorage();
  var isLoading = false.obs;
  var isSending = false.obs;
  List<dynamic> portos = [].obs;
  List<dynamic> analysts = [].obs;
  List<dynamic> publicpost = [].obs;
  final List<int> subs = [];

  // Future<void> getSubscription() async {
  //   final token = box.read('token');

  //   try {
  //     isLoading.value = true;
  //     final dio = Dio();
  //     dio.options.headers['Authorization'] = 'Bearer $token';
  //     final response =
  //         await dio.get('http://env-4734168.user.cloudjkt01.com/api/portofolio/subuser');
  //     if (response.statusCode == 200) {
  //       final data = response.data['data'];
  //       print(data);
  //       var d;
  //       for (d in data) {
  //         subs.add(d['id_analyst']);
  //       }
  //       isLoading.value = false;
  //       fetchSubsPorto('');
  //     } else {
  //       isLoading.value = false;
  //       throw Exception('Failed to load portofolio');
  //     }
  //   } catch (error) {
  //     isLoading.value = false;
  //     print(error);
  //   }
  // }

  // Future<void> fetchAnalyst() async {
  //   try {
  //     isLoading.value = true;
  //     final token = box.read('token');

  //     final dio = Dio();

  //     dio.options.headers['Authorization'] = 'Bearer $token';
  //     final response =
  //         await dio.get('http://env-4734168.user.cloudjkt01.com/api/portofolio/analyst');

  //     if (response.statusCode == 200) {
  //       final data = response.data['data'];
  //       analysts = data;
  //       isLoading.value = false;
  //       print("analysts " + analysts.toString());
  //     } else {
  //       isLoading.value = false;
  //       throw Exception('Failed to load analysts');
  //     }
  //   } catch (error) {
  //     isLoading.value = false;
  //     print(error);
  //   }
  // }

  // Future<void> fetchSubsPorto(String typeName) async {
  //   var sType = '';
  //   if (typeName != 'semua') {
  //     sType = typeName;
  //   }
  //   try {
  //     isLoading.value = true;
  //     final token = box.read('token');

  //     final dio = Dio();
  //     Map<String, dynamic> data = {
  //       'type': '',
  //       'analyst_id': jsonEncode(subs),
  //     };
  //     final params = {
  //       'type': sType,
  //       'analyst_id': jsonEncode(subs),
  //     };
  //     print(params);
  //     dio.options.headers['Authorization'] = 'Bearer $token';
  //     final response = await dio.post(
  //       'http://env-4734168.user.cloudjkt01.com/api/portofolio/subs',
  //       data: data,
  //     );
  //     // print(response.data['data']);
  //     if (response.statusCode == 200) {
  //       final data = response.data['data'];
  //       portos = data;
  //       isLoading.value = false;
  //       print("subs porto " + portos.toString());
  //     } else {
  //       isLoading.value = false;
  //       throw Exception('Failed to load portofolio');
  //     }
  //   } catch (error) {
  //     isLoading.value = false;
  //     print(error);
  //   }
  // }

  Future<void> fetchPublicPost() async {
    try {
      print("Fetching all public post");
      isLoading.value = true;
      final token = box.read('token');
      final idpost = arguments['id_post'];
      var apiUrl =
          'http://env-4734168.user.cloudjkt01.com/api/post/view/$idpost';

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        var result = jsonDecode(response.body)['data'];

        publicpost = result;
        print('ini public post');
        print(publicpost);
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

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    // fetchAnalyst();
    print('ini public post');
    fetchPublicPost();
    //getSubscription();
    // fetchSubsPorto('');
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
