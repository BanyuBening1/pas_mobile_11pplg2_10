import 'package:get/get.dart';
import 'package:pas_mobile_11pplg2_10/controller/tv_show_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<TvShowController>(() => TvShowController());
  }
}
