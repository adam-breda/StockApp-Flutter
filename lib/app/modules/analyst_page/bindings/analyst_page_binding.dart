import 'package:get/get.dart';

import '../controllers/analyst_page_controller.dart';

class AnalystPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnalystPageController>(
      () => AnalystPageController(),
    );
  }
}
