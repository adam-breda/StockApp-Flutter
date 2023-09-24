import 'package:flutter/material.dart';

import '../api/api_service.dart';
import '../models/JenisSaham.dart';
import '../modules/company_detail/controllers/company_detail_controller.dart';

class JenisSahamDropDown extends StatelessWidget {
  final ApiService apiService;
  final CompanyDetailController controller;
  const JenisSahamDropDown(
      {super.key, required this.apiService, required this.controller});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<JenisSaham>>(
      future: apiService.fetchJenisSaham(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<JenisSaham> jenisSaham = snapshot.data!;

          return ListView.builder(
            itemCount: jenisSaham.length,
            itemBuilder: (context, index) {
              final jenisItem = jenisSaham[index];
              return Padding(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(jenisItem.id_jenis_saham.toString()),
                            Text(jenisItem.jenis_saham)
                          ],
                        ))),
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
    );
  }
}
