import 'package:get/get.dart';
import '../controllers/add_plan_controller.dart';

import '../../../models/Company.dart';
import '../../../routes/app_pages.dart';

class PlanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddPlanController>(
      () => AddPlanController(),
    );
  }
}
