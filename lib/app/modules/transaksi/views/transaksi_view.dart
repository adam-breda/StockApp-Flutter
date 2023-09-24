import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/transaksi_controller.dart';

class TransaksiView extends GetView<TransaksiController> {
  TransaksiView({Key? key}) : super(key: key);
  final TransaksiController controller = Get.put(TransaksiController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.arguments['type']),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TransaksiView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
