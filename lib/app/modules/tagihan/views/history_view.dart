import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../Values/values.dart';
import '../../../api/api_service.dart';
import '../../../models/Tagihan.dart';
import '../../../routes/app_pages.dart';
import '../controllers/tagihan_controller.dart';

class HistoryView extends GetView<TagihanController> {
  HistoryView({Key? key}) : super(key: key);
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
          future: apiService.fetchTagihan('Lunas'),
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
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                              tagihanItem.metode_pembayaran
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black87),
                                            ),
                                            SizedBox(
                                              height: 2,
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
