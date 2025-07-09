import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/components/common_image_view.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/components/greenpool_textfield.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';
import '../../../../generated/locales.g.dart';
import '../../../constants/image_constant.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/refer_friend_controller.dart';

class AddContactReferFriendsView extends GetView<ReferFriendsController> {
  const AddContactReferFriendsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GreenPoolAppBar(
        title: Text(LocaleKeys.app_referAFriends.tr),
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 12.kh),
                      Text(
                        LocaleKeys.app_add_contact_and_easily_invite.tr,
                        style: TextStyleUtil.k14Regular(),
                      ).paddingOnly(bottom: 28.kh),
                      SizedBox(
                        height: 52,
                        width: Get.width,
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          itemCount: 50,
                          itemBuilder: (context, index) {
                            return Stack(
                              clipBehavior: Clip.none,
                              children: [
                                 const SizedBox(width: 52),
                                if(index == 0)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: CommonImageView(
                                        height: 52,
                                        width: 52,
                                        fit: BoxFit.cover,
                                        alignment: Alignment.topCenter,
                                        url:
                                        'https://cdn.pixabay.com/photo/2024/05/22/20/47/doctor-8781659_1280.png' ??
                                            ""),
                                  ),
                                if(index != 0)
                                Positioned(
                                  right: index * 7,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: CommonImageView(
                                        height: 52,
                                        width: 52,
                                        fit: BoxFit.cover,
                                        alignment: Alignment.topCenter,
                                        url:
                                        'https://cdn.pixabay.com/photo/2024/05/22/20/47/doctor-8781659_1280.png' ??
                                            ""),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ).paddingOnly(bottom: 28.kh),
                      // SizedBox(
                      //   height: 52,
                      //   child: SingleChildScrollView(
                      //     scrollDirection: Axis.horizontal,
                      //     physics: const BouncingScrollPhysics(),
                      //     child: Row(
                      //       children: List.generate(50, (index) {
                      //         return Transform.translate(
                      //           offset: Offset(index == 0 ? 0 : -15, 0), // overlapping effect
                      //           child: Container(
                      //             height: 52,
                      //             width: 52,
                      //             decoration: BoxDecoration(
                      //               shape: BoxShape.circle,
                      //               border: Border.all(color: Colors.white, width: 2),
                      //               image: const DecorationImage(
                      //                 fit: BoxFit.cover,
                      //                 image: NetworkImage(
                      //                   'https://cdn.pixabay.com/photo/2024/05/22/20/47/doctor-8781659_1280.png',
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         );
                      //       }),
                      //     ),
                      //   ),
                      // ),



                      // SizedBox(
                      //   height: 52,
                      //   width: Get.width,
                      //   child: Stack(
                      //    alignment: Alignment.center,
                      //     children: List.generate(25, (index) {
                      //       return Positioned(
                      //         left: index * 42,
                      //         child: ClipRRect(
                      //           borderRadius: BorderRadius.circular(100),
                      //           child: CommonImageView(
                      //               height: 52,
                      //               width: 52,
                      //               fit: BoxFit.cover,
                      //               alignment: Alignment.topCenter,
                      //               url: 'https://cdn.pixabay.com/photo/2024/05/22/20/47/doctor-8781659_1280.png' ?? ""),
                      //         ),
                      //       );
                      //     }),
                      //   ),
                      // ).paddingOnly(bottom: 28.kh),

                      // SizedBox(
                      //   height: 55,
                      //   child: ListView.builder(
                      //     shrinkWrap: true,
                      //     padding: EdgeInsets.zero,
                      //     scrollDirection: Axis.horizontal,
                      //     itemCount: 52,
                      //     itemBuilder: (context, index) {
                      //       return Stack(
                      //         clipBehavior: Clip.none,
                      //         children: [
                      //           const SizedBox(
                      //             height: 52,
                      //             width: 52,
                      //           ),
                      //           if(index == 0)
                      //           ClipRRect(
                      //             borderRadius: BorderRadius.circular(100),
                      //             child: CommonImageView(
                      //                 height: 52,
                      //                 width: 52,
                      //                 fit: BoxFit.cover,
                      //                 alignment: Alignment.topCenter,
                      //                 url: 'https://cdn.pixabay.com/photo/2024/05/22/20/47/doctor-8781659_1280.png' ?? ""),
                      //           ),
                      //           Positioned(
                      //             left: 10,
                      //             child: ClipRRect(
                      //               borderRadius: BorderRadius.circular(100),
                      //               child: CommonImageView(
                      //                   height: 52,
                      //                   width: 52,
                      //                   fit: BoxFit.cover,
                      //                   alignment: Alignment.topCenter,
                      //                   url: 'https://cdn.pixabay.com/photo/2024/05/22/20/47/doctor-8781659_1280.png' ?? ""),
                      //             ),
                      //           )
                      //         ],
                      //       );
                      //     },
                      //   ),
                      // ).paddingOnly(bottom: 28.kh),
                      Text(
                        LocaleKeys.invite_your_carpool_buddies_via_text.tr,
                        style: TextStyleUtil.k14Regular(),
                      ).paddingOnly(bottom: 28.kh),
                    ],
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
               Column(
                  children: [
                    GreenPoolButton(
                      borderRadius: 6,
                      onPressed: () {},
                      label: LocaleKeys.app_addContacts.tr,
                    ),
                    GreenPoolButton(
                      borderRadius: 6,
                      color: ColorUtil.kWhiteColor,
                      onPressed: () {},
                      label: LocaleKeys.no_thanks.tr,
                    ).paddingSymmetric(vertical: 10.kh),
                  ],
                ),

            ],
          ).paddingSymmetric(horizontal: 16.kw),
        ],
      ),
    );
  }
}
