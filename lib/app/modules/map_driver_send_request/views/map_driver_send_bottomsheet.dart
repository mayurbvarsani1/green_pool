import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/components/common_image_view.dart';
import 'package:green_pool/app/components/origin_to_destination.dart';
import 'package:green_pool/app/data/driver_send_request_model.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../../generated/locales.g.dart';
import '../../../components/green_pool_divider.dart';
import '../../../constants/image_constant.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/text_style_util.dart';
import '../../../utils/date_utils.dart';
import '../../home/controllers/home_controller.dart';

class MapDriverSendBottomsheet extends StatelessWidget {
  DriverSendRequestModelData? element;

  MapDriverSendBottomsheet({super.key, required this.element});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(24.kh),
        // height: 317.kh,
        width: 100.w,
        decoration: BoxDecoration(
            color: ColorUtil.kWhiteColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.kh),
                topRight: Radius.circular(40.kh))),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                LocaleKeys.app_rideRequest.tr,
                style: TextStyleUtil.k18Heading600(),
              ).paddingOnly(bottom: 32.kh),
              const GreenPoolDivider().paddingSymmetric(vertical: 16.kh),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: ClipOval(
                        child: SizedBox.fromSize(
                            size: Size.fromRadius(20.kh),
                            child: CommonImageView(
                              url: element?.riderDetails?.profilePic?.url,
                            )),
                      ),
                    ).paddingOnly(right: 8.kw),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          element?.riderDetails?.fullName ?? "",
                          style: TextStyleUtil.k16Semibold(fontSize: 16.kh),
                        ).paddingOnly(bottom: 8.kh),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  ImageConstant.svgIconCalendarTime,
                                  colorFilter: ColorFilter.mode(
                                      Get.find<HomeController>().isPinkModeOn.value? ColorUtil.kPrimary3PinkMode : ColorUtil.kSecondary01,
                                      BlendMode.srcIn),
                                ).paddingOnly(right: 4.kw),
                                Text(
                                  (DateTimeUtils.getDateFormat(element?.time ?? "") +
                                      DateTimeUtils.convertUtcToLocal(
                                          element?.time ?? "")),
                                  style: TextStyleUtil.k12Regular(
                                      color: ColorUtil.kBlack02),
                                ),
                              ],
                            ),],
                        ),
                      ],
                    ),
                  ],
                ),
                const GreenPoolDivider(),
                OriginToDestination(
                  needPickupText: false,
                  origin: element?.origin?.name ?? "",
                  destination: element?.destination?.name ?? "",
                ).paddingSymmetric(vertical: 8.kh),
                const GreenPoolDivider().paddingOnly(bottom: 16.kh),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      //rating column
                      children: [
                        Text(
                          LocaleKeys.app_rating.tr,
                          style: TextStyleUtil.k12Semibold(),
                        ).paddingOnly(bottom: 4.kh),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.kw, vertical: 2.kh),
                          decoration: BoxDecoration(
                            color: Get.find<HomeController>().isPinkModeOn.value
                                ? ColorUtil.kPrimary3PinkMode
                                : ColorUtil.kPrimary01,
                            borderRadius: BorderRadius.circular(16.kh),
                          ),
                          child: Row(children: [
                            Icon(
                              Icons.star,
                              color: ColorUtil.kWhiteColor,
                              size: 12.kh,
                            ).paddingOnly(right: 4.kw),
                            Text(
                              element?.riderDetails?.rating.toString() ?? "0.0",
                              style: TextStyleUtil.k14Regular(),
                            ),
                          ]),
                        ),
                      ],
                    ),
                    Column(
                      //ride with column
                      children: [
                        Text(
                          LocaleKeys.app_totalRides.tr,
                          style: TextStyleUtil.k12Semibold(),
                        ).paddingOnly(bottom: 4.kh),
                        Text(
                          element?.riderDetails?.totalRides.toString() ?? "0",
                          style: TextStyleUtil.k14Regular(
                              color: ColorUtil.kBlack03),
                        ),
                      ],
                    ),
                    Column(
                      //joined in column
                      children: [
                        Text(
                          LocaleKeys.app_joined.tr,
                          style: TextStyleUtil.k12Semibold(),
                        ).paddingOnly(bottom: 4.kh),
                        Text(
                          '${LocaleKeys.app_inA.tr} ${element?.riderDetails?.createdAt?.substring(0, 4) ?? 2024}',
                          style: TextStyleUtil.k14Regular(
                              color: ColorUtil.kBlack03),
                        ),
                      ],
                    ),
                  ],
                ),
                const GreenPoolDivider().paddingOnly(bottom: 16.kh, top: 8.kh),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GreenPoolButton(
                      onPressed: () {},
                      label: LocaleKeys.app_accept.tr,
                      fontSize: 14.kh,
                      height: 40.kh,
                      width: 144.kw,
                      padding: EdgeInsets.all(8.kh),
                    ),
                    GreenPoolButton(
                      onPressed: () {},
                      isBorder: true,
                      label: LocaleKeys.app_reject.tr,
                      fontSize: 14.kh,
                      height: 40.kh,
                      width: 144.kw,
                      borderColor: Get.find<HomeController>().isPinkModeOn.value
                          ? ColorUtil.kPrimary3PinkMode
                          : ColorUtil.kSecondary01,
                      labelColor: Get.find<HomeController>().isPinkModeOn.value
                          ? ColorUtil.kPrimary3PinkMode
                          : ColorUtil.kSecondary01,
                      padding: EdgeInsets.all(8.kh),
                    ),
                  ],
                ),
              ]),
            ],
          ),
        ));
  }

  Widget text(String s) {
    return Text(
      s,
      style: TextStyleUtil.k12Regular(color: ColorUtil.kBlack02),
    );
  }
}
