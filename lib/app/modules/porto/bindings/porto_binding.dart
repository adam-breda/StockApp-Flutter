import 'package:get/get.dart';

import '../controllers/porto_controller.dart';

class PortoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PortoController>(
      () => PortoController(),
    );
  }
}
