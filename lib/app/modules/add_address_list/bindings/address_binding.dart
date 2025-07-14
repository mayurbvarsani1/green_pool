import 'package:get/get.dart';
import 'package:green_pool/app/modules/add_address_list/controllers/address_controller.dart';


class AddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddressesController>(
      () => AddressesController(),
    );
  }
}
