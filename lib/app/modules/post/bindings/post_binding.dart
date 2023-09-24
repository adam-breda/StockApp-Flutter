import 'package:get/get.dart';
import 'package:stock_app/app/modules/post/controllers/post_controller.dart';

class PostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostController>(
      () => PostController(),
    );
  }
}
