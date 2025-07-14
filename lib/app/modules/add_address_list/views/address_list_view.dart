import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/components/gp_progress.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/components/greenpool_textfield.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/data/user_address_list_model.dart';
import 'package:green_pool/app/modules/add_address_list/controllers/address_controller.dart';
import 'package:green_pool/app/modules/add_address_list/views/add_address_view.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';
import '../../../../generated/locales.g.dart';


class AddressListView extends GetView<AddressesController> {

  AddressListView({super.key,});
  AddressesController  controller = Get.put(AddressesController());
  @override
  Widget build(BuildContext context) {
    final isPinkModeOn = Get.find<HomeController>().isPinkModeOn.value;

    return Scaffold(
      appBar: GreenPoolAppBar(
        title: Text(LocaleKeys.app_destinations.tr),
      ),
      resizeToAvoidBottomInset: false,
      body: Obx(
        () => controller.isLoad.value ?
        const GpProgress() :
        SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 12.kh,
              ),
              GreenPoolTextField(
                textStyle: TextStyleUtil.k14Medium(color: ColorUtil.kBlack01),
                hintText: LocaleKeys.app_enterAddressDestination.tr,
                keyboardType: TextInputType.streetAddress,
                onchanged: (v) {
                  // controller.setActiveState();
                },
                onTap: () {
                  // controller.moveToSetOrigin();
                },
                controller: controller.riderOriginTextController,
                readOnly: true,
                prefix: SvgPicture.asset(
                  ImageConstant.location,
                  // width: 30,
                  // height: 30,
                  colorFilter: ColorFilter.mode(
                      isPinkModeOn ? ColorUtil.kPrimary3PinkMode : ColorUtil.kSecondary01,
                      BlendMode.srcIn),
                ),
                // prefix: Icon(
                //   Icons.location_on,
                //   size: 24.kh,
                //   color: isPinkModeOn ? ColorUtil.kPrimary3PinkMode : ColorUtil.kSecondary01,
                // ),
                suffix: controller.isOriginAdded.value
                    ? InkWell(
                    onTap: () {
                      controller.removeOrigin();
                    } ,
                    child: const Icon(Icons.cancel))
                    : const SizedBox(),
              ).paddingOnly(top: 8.kh, bottom: 20.kh),
              Text(
                LocaleKeys.app_savedAddresses.tr,
                style: TextStyleUtil.k16Semibold(
                    fontWeight: FontWeight.w600, fontSize: 16),
              ).paddingOnly(bottom: 16.kh),
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: controller.addressDataList?.friendAddresses?.length ?? 0,
                itemBuilder: (context, index) {
                  FriendAddress? addressData = controller.addressDataList?.friendAddresses?[index];
                  return Container(
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      // color: ColorUtil.kNeutral1,
                      // border: Border(top: BorderSide.none,bottom: BorderSide(width: 1.kh,color: ColorUtil.kNeutral7)),
                        borderRadius: BorderRadius.circular(8.kh)),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () {
                        // controller.addressListGetAPI();
                      },
                      leading: SvgPicture.asset(
                        ImageConstant.location,
                        width: 26,
                        height: 26,
                        colorFilter: ColorFilter.mode(
                            isPinkModeOn
                                ? ColorUtil.kPrimary3PinkMode
                                : ColorUtil.kSecondary01,
                            BlendMode.srcIn),
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          Get.to(() => AddAddressView());
                        },
                        child: SvgPicture.asset(
                          ImageConstant.editIcon,
                          width: 24,
                          height: 24,
                          colorFilter: ColorFilter.mode(
                              isPinkModeOn
                                  ? ColorUtil.kPrimary3PinkMode
                                  : ColorUtil.kSecondary01,
                              BlendMode.srcIn),
                        ),
                      ),
                      title: Text(addressData?.name ?? "",
                          style: TextStyleUtil.k16Medium(
                              fontWeight: FontWeight.w500)),
                      subtitle: Text(
                        addressData?.type ?? "",
                        style: TextStyleUtil.k11Regular(
                            fontWeight: FontWeight.w400,
                            color: ColorUtil.appGray),
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: () {

                },
                leading: SvgPicture.asset(
                  ImageConstant.location,
                  width: 26,
                  height: 26,
                  colorFilter: ColorFilter.mode(
                      isPinkModeOn
                          ? ColorUtil.kPrimary3PinkMode
                          : ColorUtil.kSecondary01,
                      BlendMode.srcIn),
                ),
                trailing: GestureDetector(
                  onTap: () {
                    Get.to(() => AddAddressView());
                  },
                  child: SvgPicture.asset(
                    ImageConstant.editIcon,
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                        isPinkModeOn
                            ? ColorUtil.kPrimary3PinkMode
                            : ColorUtil.kSecondary01,
                        BlendMode.srcIn),
                  ),
                ),
                title: Text(LocaleKeys.app_createNewEvent.tr,
                    style: TextStyleUtil.k16Medium(
                        fontWeight: FontWeight.w500)),
                subtitle: Text(
                  "addressData?.type" ?? "",
                  style: TextStyleUtil.k11Regular(
                      fontWeight: FontWeight.w400,
                      color: ColorUtil.appGray),
                ),
              ),

            ],
          ).paddingSymmetric(horizontal: 16.kw),
        ),
      ),
    );
  }
}

