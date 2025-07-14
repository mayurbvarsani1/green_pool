import 'package:get/get.dart';

import '../controllers/address_destination_controller.dart';


class AddressDestinationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddressDestinationController>(
      () => AddressDestinationController(),
    );
  }
}
