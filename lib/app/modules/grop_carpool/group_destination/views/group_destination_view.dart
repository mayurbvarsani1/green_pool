import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../components/gp_progress.dart';
import '../../../../components/greenpool_textfield.dart';
import '../../../../services/colors.dart';
import '../../../../services/text_style_util.dart';
import '../../../home/controllers/home_controller.dart';
import '../controllers/group_destination_controller.dart';

class GroupDestinationView extends GetView<GroupDestinationController> {
  const GroupDestinationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GreenPoolAppBar(
          title: Text(LocaleKeys.app_destinations.tr)
        ),
        body: Column(
          children: [
            Obx(
              () => GreenPoolTextField(
                hintText: LocaleKeys.app_enterADestination.tr,
                controller: controller.originController,
                onchanged: (value) {
                  controller.setSessionToken();
                },
                autofocus: true,
                prefix: Icon(
                  Icons.location_on,
                  size: 24.kh,
                  color: Get.find<HomeController>().isPinkModeOn.value
                      ? ColorUtil.kPrimary3PinkMode
                      : ColorUtil.kSecondary01,
                ),
              ).paddingOnly(top: 32.kh, bottom: 16.kh),
            ),
            //cache location
            Obx(
              () => Visibility(
                visible: controller.findLocationModels.isNotEmpty &&
                    !controller.hidePrevLoc.value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.app_previouslySearched.tr,
                      style: TextStyleUtil.k14Semibold(),
                    ).paddingOnly(bottom: 8.kh),
                    SizedBox(
                      height: 250.kh,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics:
                            const ClampingScrollPhysics(), // Avoid conflicting scroll physics
                        itemCount: controller.findLocationModels.length,
                        itemBuilder: (context, index) {
                          var item = controller.findLocationModels[index];
                          return Container(
                            decoration: BoxDecoration(
                                color: ColorUtil.kNeutral7.withOpacity(0.5),
                                border: Border(
                                    top: BorderSide.none,
                                    bottom: BorderSide(
                                        width: 1.kh,
                                        color: ColorUtil.kNeutral7)),
                                borderRadius: BorderRadius.circular(8.kh)),
                            child: ListTile(
                              onTap: () {
                                controller.setLocationFromCache(
                                    controller.locationValues.name, index);
                              },
                              leading: const Icon(
                                Icons.history,
                                color: ColorUtil.kNeutral4,
                              ),
                              title: Text(item["address"] ?? "Unknown Address"),
                            ),
                          ).paddingOnly(bottom: 2.kh);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Obx(
                () => controller.isLoading.value
                    ? const GpProgress()
                    : ListView.builder(
                        itemCount: controller.addressSugestionList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1.kh,
                                        color: ColorUtil.kNeutral7)),
                                borderRadius: BorderRadius.circular(8.kh)),
                            child: ListTile(
                              title: Text(controller.addressSugestionList[index]
                                  ['description']),
                              onTap: () async {
                                await controller.setLocationData(controller
                                    .addressSugestionList[index]['place_id']);
                                controller.resetSessionToken();
                                // Get.back(
                                //     result: controller.postRideModel.value);
                              },
                            ),
                          );
                        }),
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 16.kw));
  }
}
