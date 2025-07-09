import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/common_image_view.dart';
import 'package:green_pool/app/components/gp_progress.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/components/greenpool_textfield.dart';
import 'package:green_pool/app/modules/refer_friends/bottomsheet_ui.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../../../../generated/locales.g.dart';
import '../../../constants/image_constant.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/refer_friend_controller.dart';

class ReferFriendsView extends GetView<ReferFriendsController> {
  const ReferFriendsView({super.key});
  @override
  Widget build(BuildContext context) {
    final isPinkModeOn = Get.find<HomeController>().isPinkModeOn.value;

    return Scaffold(
      appBar: GreenPoolAppBar(
        title: Text(LocaleKeys.app_referAFriends.tr),
      ),
      resizeToAvoidBottomInset: false,
      body:Stack(
        children: [

          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 12.kh),
              CommonImageView(
                fit: BoxFit.cover,
                // width: Get.width,

                height: 144,
                imagePath: ImageConstant.referFriendsImg,
              ).paddingOnly(bottom: 25.kh),
              GreenPoolTextField(
                  hintText: LocaleKeys.search_by_name.tr,
                  controller: controller.searchTextController,
                  onchanged: (v) {
                    // controller.searchMethod();

                  },
                  prefix: Icon(
                    Icons.search,
                    color: Get.find<HomeController>().isPinkModeOn.value
                        ? ColorUtil.kPrimary3PinkMode
                        : ColorUtil.kBlack02,
                  ),
                  onPressedSuffix: () {
                    if (controller.isSelected.value == true) {
                      controller.schoolListAPI('university');
                      controller.isSelected.value = false;
                    } else {
                      controller.isSelected.value = true;
                    }
                  },
                  suffix: controller.isSelected.value
                      ? const Icon(
                    Icons.chevron_right,
                    color: ColorUtil.kBlack01,
                  )
                      : const Icon(
                    Icons.keyboard_arrow_down,
                    color: ColorUtil.kBlack01,
                  ))
                  .paddingOnly(bottom: 16.kh),


                Expanded(
                child: SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 10,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, itemsIndex) {
                      return GestureDetector(onTap: () {
                        Get.bottomSheet(const ReportBlockBottomSheet(),
                            enableDrag: true, isScrollControlled: true);
                      },
                        child: ListTile(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.kh)),
                          minVerticalPadding: 12.kh,
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            "Tongkun Lee",
                              style: TextStyleUtil.k16Bold(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            "Facebook",
                            style: TextStyleUtil.k14Regular(color: const Color(0xFF6B7582)),
                          ),
                          leading: Container(
                            padding: EdgeInsets.all(16.kh),
                            height: 212.kh,
                            width: 15.w,
                            decoration: BoxDecoration(
                              color: ColorUtil.kBlack08,
                              shape: BoxShape.circle
                            ),
                            alignment: Alignment.center,
                            child: CommonImageView(
                                height: 212.kh,
                                width: 15.w,
                                // fit: BoxFit.fitHeight,
                                // alignment: Alignment.topCenter,
                                url: 'https://cdn.pixabay.com/photo/2016/11/21/12/54/man-1845259_1280.jpg' ?? ""),

                          ),
                         trailing: GestureDetector(
                           onTap: () {
                             Get.toNamed(Routes.REFER_FRIENDS_ADD_CONTACT);
                           },
                           child: Container(
                             height: 38,
                             width: 58,
                             alignment: Alignment.center,
                             decoration: BoxDecoration(
                             color: ColorUtil.kPrimary01 ,borderRadius: BorderRadius.circular(10)
                           ),
                             child: Text(LocaleKeys.app_invite.tr,style: TextStyleUtil.k12Bold(color: ColorUtil.kSecondary01),),
                           ),
                         ),
                         // trailing:  GreenPoolButton(
                         //   borderRadius: 12,
                         //   height: 40.kh,
                         //   width: 18.w,
                         //   fontSize: 14,
                         //   onPressed: () {
                         //     debugPrint("in app");
                         //     Get.toNamed(Routes.REFER_FRIENDS_ADD_CONTACT);
                         //     // controller.checkEmailPostFix();
                         //   },
                         //   label: LocaleKeys.app_invite.tr,
                         // )
                        ).paddingOnly(bottom: 4.kh),
                      );
                    },
                  ),
                ),
              ),


               SizedBox(height: 0.50.h,),
              Obx(
                    () => GreenPoolButton(
                  borderRadius: 6,
                  onPressed: () {
                    // controller.checkEmailPostFix();
                  },
                  label: LocaleKeys.app_done.tr,
                  isActive: controller.isActive.value,
                ).paddingSymmetric(vertical: 20.kw),
              ),

            ],
          ).paddingSymmetric(horizontal: 16.kw),


        ],
      ),
    );
  }
}
