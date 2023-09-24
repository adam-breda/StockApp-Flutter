import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../Values/values.dart';
import '../../../api/api_service.dart';
import '../../../models/Tagihan.dart';
import '../../../routes/app_pages.dart';
import '../controllers/tagihan_controller.dart';

class TagihanView extends GetView<TagihanController> {
  TagihanView({Key? key}) : super(key: key);
  final TagihanController controller = Get.put(TagihanController());
  final ApiService apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primary,
        // appBar: AppBar(
        //   title: const Text('Tagihan'),
        // ),
        body: FutureBuilder<List<Tagihan>>(
          future: apiService.fetchTagihan('Menunggu Pembayaran'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<Tagihan> tagihan = snapshot.data!;

              return ListView.builder(
                padding: EdgeInsets.only(top: 10.0),
                itemCount: tagihan.length,
                itemBuilder: (context, index) {
                  final tagihanItem = tagihan[index];
                  final formatter = NumberFormat('#,###', 'id');
                  return Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Card(
                          color: secondary,
                          elevation: 3,
                          child: Padding(
                              padding: EdgeInsets.all(10),
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.PAYMENT, arguments: {
                                    'nama': tagihanItem.nama,
                                    'id': tagihanItem.id,
                                    'jumlah': tagihanItem.jumlah,
                                    'status': tagihanItem.status
                                  });
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              tagihanItem.nama,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'ID TRX : ${tagihanItem.reference}',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black38),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              tagihanItem.status,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green),
                                            ),
                                          ],
                                        ),
                                        Container(
                                            child: Text(
                                                formatter
                                                    .format(tagihanItem.jumlah),
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        Colors.redAccent[400])))
                                      ],
                                    )
                                  ],
                                ),
                              )),
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
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
