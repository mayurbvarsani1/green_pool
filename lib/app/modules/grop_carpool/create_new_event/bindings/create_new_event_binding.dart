import 'package:get/get.dart';

import '../controllers/create_new_event_controller.dart';


class EventDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateNewEventController>(
      () => CreateNewEventController(),
    );
  }
}
