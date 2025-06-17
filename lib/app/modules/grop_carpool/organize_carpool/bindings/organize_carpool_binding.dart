import 'package:get/get.dart';

import '../controllers/organize_carpool_controller.dart';



class OrganizeCarpoolBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrganizeCarpoolController>(
      () => OrganizeCarpoolController(),
    );
  }
}
