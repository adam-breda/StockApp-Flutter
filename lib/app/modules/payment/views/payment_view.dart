import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stock_app/app/models/PaymentChannel.dart';

import '../../../Values/values.dart';
import '../../../api/api_service.dart';
import '../controllers/payment_controller.dart';

class PaymentView extends GetView<PaymentController> {
  PaymentView({Key? key}) : super(key: key);
  final PaymentController controller = Get.put(PaymentController());
  final ApiService apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###', 'id');
    return Scaffold(
      backgroundColor: primary,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                controller.arguments['nama'].toString(),
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                formatter.format(controller.arguments['jumlah']).toString(),
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.redAccent[400],
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Obx(() => controller.metodePembayaran.value == ''
                  ? Container(
                      width: Get.width,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent[400]),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return PaymentChannelBottomSheet(
                                  apiService: apiService,
                                  controller: controller,
                                );
                              },
                            );
                          },
                          child: Text("Pilih Pembayaran")))
                  : Column(
                      children: [
                        Text(controller.metodePembayaran.toString()),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent[400]),
                            onPressed: () {
                              controller.payTagihan(controller.arguments['id'],
                                  controller.metodePembayaran.toString());
                              print(controller.arguments['id'].toString());
                            },
                            child: Text("Bayar"))
                      ],
                    ))
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentChannelBottomSheet extends StatelessWidget {
  final ApiService apiService;
  final PaymentController controller;
  const PaymentChannelBottomSheet(
      {super.key, required this.apiService, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          "Pilih Metode Pembayaran",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.redAccent[400]),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
            child: FutureBuilder<List<PaymentChannel>>(
          future: apiService.fetchPayment(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<PaymentChannel> paymentChannel = snapshot.data!;

              return ListView.builder(
                itemCount: paymentChannel.length,
                itemBuilder: (context, index) {
                  final paymentItem = paymentChannel[index];
                  return Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: GestureDetector(
                          onTap: () {
                            controller.metodePembayaran.value =
                                paymentItem.paymentName;

                            Navigator.pop(context);
                          },
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(paymentItem.paymentName,
                                    style: TextStyle(fontSize: 18)),
                                Divider(
                                  color: Colors.black87,
                                )
                              ]),
                        )),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error fetching data'),
              );
            }

            return Center(
              child: CircularProgressIndicator(
                color: Colors.redAccent[400],
              ),
            );
          },
        ))
      ],
    );
  }
}
