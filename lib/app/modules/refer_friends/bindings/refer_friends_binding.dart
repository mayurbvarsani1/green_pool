import 'package:get/get.dart';
import 'package:green_pool/app/modules/refer_friends/controllers/refer_friend_controller.dart';


class ReferFriendsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReferFriendsController>(
      () => ReferFriendsController(),
    );
  }
}
