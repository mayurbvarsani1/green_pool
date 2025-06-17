import 'package:get/get.dart';

import '../controllers/group_destination_controller.dart';


class GroupDestinationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GroupDestinationController>(
      () => GroupDestinationController(),
    );
  }
}
