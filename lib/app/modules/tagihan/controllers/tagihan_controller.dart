import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stock_app/app/api/api_service.dart';
import 'package:stock_app/app/models/Tagihan.dart';

class TagihanController extends GetxController {
  var isLoading = false.obs;
  var isSending = false.obs;
  var status = "Menunggu Pembayaran".obs;
  final box = GetStorage();
  final ApiService apiService = ApiService();
  RxList<Tagihan> tagihanList = RxList<Tagihan>([]);

  void getTagihan(String status) async {
    final data = await apiService.fetchTagihan(status);

    if (data != null) {
      tagihanList.assignAll(data); // Update the reactive list with fetched data
    } else {
      throw Exception('Failed to load portofolio');
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    // getTagihan('Menunggu Pembayaran');
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
