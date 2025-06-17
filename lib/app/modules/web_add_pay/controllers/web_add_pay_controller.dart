import 'package:get/get.dart';

import '../../../data/add_amount_model.dart';

class WebAddPayController extends GetxController {
  final Rx<AddAmountModelData> addAmountModel = AddAmountModelData().obs;
  final RxBool isLoading = true.obs;
  final isLoad = true.obs;
  @override
  void onInit() {
    super.onInit();
    addAmountModel.value = Get.arguments;
    isLoad.value = false;
  }
}
