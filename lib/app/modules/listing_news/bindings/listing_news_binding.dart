import 'package:get/get.dart';
import 'package:stock_app/app/modules/listing_news/controllers/listing_news_controller.dart';

class ListingNewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListingNewsController>(
      () => ListingNewsController(),
    );
  }
}
