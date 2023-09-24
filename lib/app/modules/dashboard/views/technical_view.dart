import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:stock_app/app/modules/dashboard/controllers/technical_controller.dart';
import 'package:stock_app/app/routes/app_pages.dart';
import 'package:stock_app/core.dart';

import '../../../Values/values.dart';
import '../../../models/JenisTechnical/JenisTrend.dart';
import '../../../widgets/Technical.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import 'fundamental_view.dart';

class JenisTrend {
  final String value;
  final String label;

  JenisTrend({required this.value, required this.label});

  List<JenisTrend> JenisTrends = [
    JenisTrend(value: '>', label: 'More Than'),
    JenisTrend(value: '<', label: 'Less Than'),
  ];
}

class TechnicalView extends GetView<TechnicalController> {
  TechnicalController controller = Get.put(TechnicalController());

  ValueNotifier<String> trendController = ValueNotifier<String>('');
  TextEditingController dropdownController = TextEditingController();
  final List<String> inputHistory;
  final List<String> Tampil;
  Map<String, List<String>> dynamicValues = {};

  TechnicalView(
      {required this.inputHistory,
      required this.Tampil,
      required String selectedFundamental,
      required String selectedComparison,
      required String percentValue});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primary,
      appBar: AppBar(
        title: Text(
          "Technical",
          style: TextStyle(fontWeight: FontWeight.w900, color: Colors.black),
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.popUntil(context, ModalRoute.withName('/home'));
          },
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Stock Trend',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 220,
                        child: DropdownButtonFormField<String>(
                          value: controller.selectedValueTrend,
                          onChanged: (newValue) {
                            controller.selectedValueTrend = newValue!;
                          },
                          items: <String>[
                            'empty',
                            'uptrend',
                            'downtrend',
                            'sideways',
                          ].map<DropdownMenuItem<String>>((String value) {
                            String text;
                            switch (value) {
                              case 'empty':
                                text = "All";
                                break;
                              case 'uptrend':
                                text = "Uptrend";
                                break;
                              case 'downtrend':
                                text = "Downtrend";
                                break;
                              case 'sideways':
                                text = "Sideways";
                                break;

                              default:
                                text = "Unknown"; // Handle unknown values
                            }
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                  text), // Teks yang akan ditampilkan pada dropdown
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.transparent,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Start Date',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: Get.width * 0.35,
                        child: TextField(
                          controller: controller
                              .dateStart, //editing controller of this TextField
                          decoration: InputDecoration(
                              icon: Icon(
                                  Icons.calendar_today), //icon of text field
                              labelText: "Enter Date" //label text of field
                              ),
                          readOnly:
                              true, //set it true, so that user will not able to edit text
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(
                                    2000), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101));

                            if (pickedDate != null) {
                              print(
                                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate1 =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              print(
                                  formattedDate1); //formatted date output using intl package =>  2021-03-16

                              controller.dateStart.text =
                                  formattedDate1; //set output date to TextField value.
                            } else {
                              print("Date is not selected");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'End Date',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: Get.width * 0.35,
                        child: TextField(
                          controller: controller
                              .dateEnd, //editing controller of this TextField
                          decoration: InputDecoration(
                              icon: Icon(
                                  Icons.calendar_today), //icon of text field
                              labelText: "Enter Date" //label text of field
                              ),
                          readOnly:
                              true, //set it true, so that user will not able to edit text
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(
                                    2000), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101));

                            if (pickedDate != null) {
                              print(
                                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate2 =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              print(
                                  formattedDate2); //formatted date output using intl package =>  2021-03-16

                              controller.dateEnd.text =
                                  formattedDate2; //set output date to TextField value.
                            } else {
                              print("Date is not selected");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Divider(
                    color: Colors.black,
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed(Routes.FUNDAMENTAL);
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        fixedSize: Size(430, 20),
                        backgroundColor: secondary),
                    child: Text(
                      'Fundamental',
                      style: TextStyle(
                        color: black,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Periode',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 220,
                            child: DropdownButtonFormField<String>(
                              value: controller
                                  .selectedPeriod, // Nilai dropdown yang dipilih
                              onChanged: (newValue) {
                                controller.selectedPeriod =
                                    newValue!; // Mengubah nilai dropdown yang dipilih
                              },
                              items: <String>[
                                'Yearly',
                                'Q1',
                                'Q2',
                                'Q3',
                                'Q4',
                              ].map<DropdownMenuItem<String>>((String value) {
                                String text;
                                switch (value) {
                                  case 'Yearly':
                                    text = "Yearly";
                                    break;
                                  case 'Q1':
                                    text = "Q1";
                                    break;
                                  case 'Q2':
                                    text = "Q2";
                                    break;
                                  case 'Q3':
                                    text = "Q3";
                                    break;
                                  case 'Q4':
                                    text = "Q4";
                                    break;

                                  default:
                                    text = "Unknown"; // Handle unknown values
                                }
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                      text), // Teks yang akan ditampilkan pada dropdown
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: Tampil.length,
                    itemBuilder: (context, index) {
                      final inputText = Tampil[index];
                      print(Tampil);
                      print("ini tampil");
                      print(inputText);

                      return Dismissible(
                        key: Key(Tampil[index]),
                        // onDismissed: (direction) {
                        //   removeTampil(index);
                        // },
                        background: Container(
                          color: Colors.red,
                          child: Icon(Icons.delete, color: Colors.white),
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 16.0),
                        ),
                        child: Card(
                          color: secondary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          elevation: 1,
                          margin:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          child: ListTile(
                            title: Text(
                              Tampil[index],
                              style: TextStyle(fontSize: 16),
                            ),

                            // subtitle: Text(
                            //   inputText[13],
                            //   style: TextStyle(fontSize: 14),
                            // ),
                          ),
                        ),
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          for (String inputText in inputHistory) {
                            List<String> parts = inputText.split(',');
                            if (parts.length == 3) {
                              String firstValue = parts[0];
                              String comparisonValue = parts[1];
                              String percentValue = parts[2];

                              // Ambil selectedValueParam yang dipilih
                              String selectedValueParam = firstValue;

                              // Buat nama variabel sesuai dengan selectedValueParam
                              String dynamicListName = selectedValueParam;

                              // Buat list baru jika belum ada
                              if (!dynamicValues.containsKey(dynamicListName)) {
                                dynamicValues[dynamicListName] = [];
                              }

                              // Tambahkan nilai inputHistory ke dalam list yang sesuai
                              String dynamicText =
                                  '$firstValue,$comparisonValue,$percentValue';
                              dynamicValues[dynamicListName]?.add(dynamicText);
                            }
                          }

                          // Tampilkan data yang disimpan
                          print("ini dynamic");
                          print(dynamicValues);
                          // List<String> dynamicValues = [];

                          // for (String inputText in inputHistory) {
                          //   List<String> parts = inputText.split(', ');
                          //   if (parts.length == 3) {
                          //     String firstValue = parts[0];
                          //     String comparisonValue = parts[1];
                          //     String percentValue = parts[2];

                          //     // Lakukan operasi atau penyimpanan yang diinginkan dengan nilai-nilai ini
                          //     String dynamicText =
                          //         '$firstValue, $comparisonValue, $percentValue';
                          //     dynamicValues.add(dynamicText);
                          //   }
                          // }
                          // print(
                          //     dynamicValues); // Ini adalah nilai-nilai yang telah diolah
                          controller.fetchTechnical(dynamicValues);
                          controller.tampildata(context);
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            fixedSize: Size(100, 20),
                            backgroundColor: buttoncolor),
                        child: Text('Submit'),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
