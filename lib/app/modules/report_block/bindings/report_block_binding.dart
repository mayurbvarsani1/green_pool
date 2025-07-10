import 'package:get/get.dart';
import 'package:green_pool/app/modules/report_block/controllers/report_block_controller.dart';


class ReportBlockBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportBlockController>(
      () => ReportBlockController(),
    );
  }
}
