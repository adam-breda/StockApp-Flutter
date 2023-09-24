import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../Values/values.dart';
import '../../../Values/values.dart';
import '../../../Values/values.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primary,
        appBar: AppBar(title: Text("")),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 60),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Register Account",
                        style: TextStyle(
                            color: Color.fromRGBO(49, 39, 79, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: secondary,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(223, 76, 71, 0.286),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              )
                            ]),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                color: Colors.grey,
                              ))),
                              child: TextField(
                                controller: controller.nameC,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Name',
                                    contentPadding: EdgeInsets.only(left: 5),
                                    hintStyle: TextStyle(color: Colors.grey)),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                color: Colors.grey,
                              ))),
                              child: TextField(
                                controller: controller.emailC,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Email',
                                    contentPadding: EdgeInsets.only(left: 5),
                                    hintStyle: TextStyle(color: Colors.grey)),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Obx(
                                () => TextField(
                                  obscureText: controller.hidePass == true
                                      ? true
                                      : false,
                                  controller: controller.passC,
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: controller.hidePass == true
                                            ? Icon(Icons.visibility_off)
                                            : Icon(Icons.visibility),
                                        onPressed: () {
                                          controller.hidePass == true
                                              ? controller.hidePass(false)
                                              : controller.hidePass(true);
                                          controller.register();
                                        },
                                      ),
                                      border: InputBorder.none,
                                      hintText: 'Password',
                                      contentPadding: EdgeInsets.only(left: 5),
                                      hintStyle: TextStyle(color: Colors.grey)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 50,
                        child: Center(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    fixedSize: Size(200, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    // shape: StadiumBorder(),
                                    backgroundColor: Colors.redAccent[400]),
                                onPressed: () {
                                  controller.register();
                                },
                                child: Text("Register"))),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
