import 'package:get/get.dart';
import 'package:green_pool/app/modules/report_block/controllers/block_controller.dart';


class BlockUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BlockUserController>(
      () => BlockUserController(),
    );
  }
}
