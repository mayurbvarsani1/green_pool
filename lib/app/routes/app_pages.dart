import 'package:get/get.dart';
import 'package:green_pool/app/modules/refer_friends/bindings/refer_friends_binding.dart';
import 'package:green_pool/app/modules/refer_friends/views/refer_friend_contacts_screen.dart';
import 'package:green_pool/app/modules/refer_friends/views/refer_friends_view.dart';

import '../modules/about/bindings/about_binding.dart';
import '../modules/about/views/about_view.dart';
import '../modules/add_bank_details/bindings/add_bank_details_binding.dart';
import '../modules/add_bank_details/views/add_bank_details_view.dart';
import '../modules/add_card/bindings/add_card_binding.dart';
import '../modules/add_card/views/add_card_view.dart';
import '../modules/add_gift/bindings/add_gift_binding.dart';
import '../modules/add_gift/views/add_gift_view.dart';
import '../modules/archived/bindings/archived_binding.dart';
import '../modules/archived/views/archived_view.dart';
import '../modules/chat_page/bindings/chat_page_binding.dart';
import '../modules/chat_page/views/chat_page_view.dart';
import '../modules/chat_with_experts/bindings/chat_with_experts_binding.dart';
import '../modules/chat_with_experts/views/chat_with_experts_view.dart';
import '../modules/create_account/bindings/create_account_binding.dart';
import '../modules/create_account/views/create_account_view.dart';
import '../modules/driver_details/bindings/driver_details_binding.dart';
import '../modules/driver_details/views/driver_details_view.dart';
import '../modules/driver_previous_rides/bindings/previous_rides_binding.dart';
import '../modules/driver_previous_rides/views/previous_rides_view.dart';
import '../modules/emergency_contacts/bindings/emergency_contacts_binding.dart';
import '../modules/emergency_contacts/views/emergency_contacts_view.dart';
import '../modules/file_dispute/bindings/file_dispute_binding.dart';
import '../modules/file_dispute/views/file_dispute_view.dart';
import '../modules/find_ride/bindings/find_ride_binding.dart';
import '../modules/find_ride/views/find_ride_view.dart';
import '../modules/grop_carpool/create_new_event/bindings/create_new_event_binding.dart';
import '../modules/grop_carpool/create_new_event/views/create_new_event_view.dart';
import '../modules/grop_carpool/event_details/bindings/event_details_binding.dart';
import '../modules/grop_carpool/event_details/views/event_details_view.dart';
import '../modules/grop_carpool/group_chat/bindings/group_chat_binding.dart';
import '../modules/grop_carpool/group_chat/views/group_chat_view.dart';
import '../modules/grop_carpool/group_destination/bindings/group_destination_binding.dart';
import '../modules/grop_carpool/group_destination/views/group_destination_view.dart';
import '../modules/grop_carpool/organize_carpool/bindings/organize_carpool_binding.dart';
import '../modules/grop_carpool/organize_carpool/views/organize_carpool_view.dart';
import '../modules/help_support/bindings/help_support_binding.dart';
import '../modules/help_support/views/help_support_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/bottom_navigation_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/language/bindings/language_binding.dart';
import '../modules/language/views/language_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/map_driver_confirm_request/bindings/map_driver_confirm_request_binding.dart';
import '../modules/map_driver_confirm_request/views/map_driver_confirm_request_view.dart';
import '../modules/map_driver_send_request/bindings/map_driver_send_request_binding.dart';
import '../modules/map_driver_send_request/views/map_driver_send_request_view.dart';
import '../modules/map_rider_confirm_request/bindings/map_rider_confirm_request_binding.dart';
import '../modules/map_rider_confirm_request/views/map_rider_confirm_request_view.dart';
import '../modules/map_rider_send_request/bindings/map_rider_send_request_binding.dart';
import '../modules/map_rider_send_request/views/map_rider_send_request_view.dart';
import '../modules/messages/bindings/messages_binding.dart';
import '../modules/messages/views/messages_view.dart';
import '../modules/my_rides_details/bindings/my_rides_details_binding.dart';
import '../modules/my_rides_details/views/my_rides_details_view.dart';
import '../modules/my_rides_edit/bindings/my_rides_edit_binding.dart';
import '../modules/my_rides_edit/views/my_rides_edit_view.dart';
import '../modules/my_rides_one_time/bindings/my_rides_one_time_binding.dart';
import '../modules/my_rides_one_time/views/my_rides_one_time_view.dart';
import '../modules/my_rides_page/bindings/my_rides_page_binding.dart';
import '../modules/my_rides_page/views/my_rides_page_view.dart';
import '../modules/my_rides_recurring_details/bindings/my_rides_recurring_details_binding.dart';
import '../modules/my_rides_recurring_details/views/my_rides_recurring_details_view.dart';
import '../modules/my_rides_request/bindings/my_rides_request_binding.dart';
import '../modules/my_rides_request/views/my_rides_request.dart';
import '../modules/notifications/bindings/notifications_binding.dart';
import '../modules/notifications/views/notifications_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/origin/bindings/origin_binding.dart';
import '../modules/origin/views/origin_view.dart';
import '../modules/password_changed/bindings/password_changed_binding.dart';
import '../modules/password_changed/views/password_changed_view.dart';
import '../modules/payNow/bindings/pay_now_binding.dart';
import '../modules/payNow/views/pay_now_view.dart';
import '../modules/payment/bindings/payment_binding.dart';
import '../modules/payment/views/payment_view.dart';
import '../modules/payment_method/bindings/payment_method_binding.dart';
import '../modules/payment_method/views/payment_method_view.dart';
import '../modules/policy_cancellation/bindings/policy_cancellation_binding.dart';
import '../modules/policy_cancellation/views/policy_cancellation_view.dart';
import '../modules/policy_privacy/bindings/policy_privacy_binding.dart';
import '../modules/policy_privacy/views/policy_privacy_view.dart';
import '../modules/post_ride_step_four/bindings/post_ride_step_four_binding.dart';
import '../modules/post_ride_step_four/views/post_ride_step_four_view.dart';
import '../modules/post_ride_step_one/bindings/post_ride_step_one_binding.dart';
import '../modules/post_ride_step_one/views/post_ride_step_one_view.dart';
import '../modules/post_ride_step_three/bindings/post_ride_step_three_binding.dart';
import '../modules/post_ride_step_three/views/post_ride_step_three_view.dart';
import '../modules/post_ride_step_two/bindings/post_ride_step_two_binding.dart';
import '../modules/post_ride_step_two/views/post_ride_step_two_view.dart';
import '../modules/prev_posted/bindings/prev_posted_binding.dart';
import '../modules/prev_posted/views/prev_posted_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/profile_settings/bindings/profile_settings_binding.dart';
import '../modules/profile_settings/views/profile_settings_view.dart';
import '../modules/profile_setup/bindings/profile_setup_binding.dart';
import '../modules/profile_setup/views/profile_setup_view.dart';
import '../modules/push_notifications/bindings/push_notifications_binding.dart';
import '../modules/push_notifications/views/push_notifications_view.dart';
import '../modules/rating_driver_side/bindings/rating_driver_side_binding.dart';
import '../modules/rating_driver_side/views/rating_driver_side_view.dart';
import '../modules/rating_rider_side/bindings/rating_rider_side_binding.dart';
import '../modules/rating_rider_side/views/rating_rider_side_view.dart';
import '../modules/report/bindings/report_binding.dart';
import '../modules/report/views/report_view.dart';
import '../modules/reset_password/bindings/reset_password_binding.dart';
import '../modules/reset_password/views/reset_password_view.dart';
import '../modules/ride_details/bindings/ride_details_binding.dart';
import '../modules/ride_details/views/ride_details_view.dart';
import '../modules/ride_history/bindings/ride_history_binding.dart';
import '../modules/ride_history/views/ride_history_view.dart';
import '../modules/rider_confirmed_ride_details/bindings/rider_confirmed_ride_details_binding.dart';
import '../modules/rider_confirmed_ride_details/views/rider_confirmed_ride_details_view.dart';
import '../modules/rider_matching_rides/bindings/matching_rides_binding.dart';
import '../modules/rider_matching_rides/views/matching_rides_view.dart';
import '../modules/rider_my_ride_request/bindings/rider_ride_request_binding.dart';
import '../modules/rider_my_ride_request/views/rider_my_ride_request_view.dart';
import '../modules/rider_my_rides_confirm_details/bindings/rider_my_rides_confirm_details_binding.dart';
import '../modules/rider_my_rides_confirm_details/views/rider_my_rides_confirm_details_view.dart';
import '../modules/rider_my_rides_send_details/bindings/rider_my_rides_send_details_binding.dart';
import '../modules/rider_my_rides_send_details/views/rider_my_rides_send_details_view.dart';
import '../modules/rider_profile_setup/bindings/rider_profile_setup_binding.dart';
import '../modules/rider_profile_setup/views/rider_profile_setup_view.dart';
import '../modules/rider_start_ride_map/bindings/rider_start_ride_map_binding.dart';
import '../modules/rider_start_ride_map/views/rider_start_ride_map_view.dart';
import '../modules/search_address/bindings/search_address_binding.dart';
import '../modules/search_address/views/search_address_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/start_ride/bindings/start_ride_binding.dart';
import '../modules/start_ride/views/start_ride_view.dart';
import '../modules/student_discounts/bindings/student_discounts_binding.dart';
import '../modules/student_discounts/views/student_discounts_view.dart';
import '../modules/submit_dispute/bindings/submit_dispute_binding.dart';
import '../modules/submit_dispute/views/submit_dispute_view.dart';
import '../modules/terms_conditions/bindings/terms_conditions_binding.dart';
import '../modules/terms_conditions/views/terms_conditions_view.dart';
import '../modules/transaction_history/bindings/transaction_history_binding.dart';
import '../modules/transaction_history/views/transaction_history_view.dart';
import '../modules/user_details/bindings/user_details_binding.dart';
import '../modules/user_details/views/user_details_view.dart';
import '../modules/vehicle_details/bindings/vehicle_details_binding.dart';
import '../modules/vehicle_details/views/vehicle_details_view.dart';
import '../modules/vehicle_setup/bindings/vehicle_setup_binding.dart';
import '../modules/vehicle_setup/views/vehicle_setup_view.dart';
import '../modules/verification_done/bindings/verification_done_binding.dart';
import '../modules/verification_done/views/verification_done_view.dart';
import '../modules/verify/bindings/verify_binding.dart';
import '../modules/verify/views/verify_view.dart';
import '../modules/wallet/bindings/wallet_binding.dart';
import '../modules/wallet/views/wallet_view.dart';
import '../modules/wallet_add_money/bindings/wallet_add_money_binding.dart';
import '../modules/wallet_add_money/views/wallet_add_money_view.dart';
import '../modules/wallet_to_bank_acc/bindings/wallet_to_bank_acc_binding.dart';
import '../modules/wallet_to_bank_acc/views/wallet_to_bank_acc_view.dart';
import '../modules/web_add_pay/bindings/web_add_pay_binding.dart';
import '../modules/web_add_pay/views/web_add_pay_view.dart';
import '../modules/web_add_to_bank/bindings/web_add_to_bank_binding.dart';
import '../modules/web_add_to_bank/views/web_add_to_bank_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.BOTTOM_NAVIGATION,
      page: () => const BottomNavigationView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.MY_RIDES_ONE_TIME,
      page: () => MyRidesOneTimeView(),
      binding: MyRidesOneTimeBinding(),
    ),
    GetPage(
      name: _Paths.MY_RIDES_REQUEST,
      page: () => const MyRideRequestsView(),
      binding: MyRidesRequestBinding(),
    ),
    GetPage(
      name: _Paths.MESSAGES,
      page: () => const MessagesView(),
      binding: MessagesBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => const NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: _Paths.ORIGIN,
      page: () => const OriginView(),
      binding: OriginBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_PAGE,
      page: () => const ChatPageView(),
      binding: ChatPageBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_ACCOUNT,
      page: () => const CreateAccountView(),
      binding: CreateAccountBinding(),
    ),
    GetPage(
      name: _Paths.VERIFY,
      page: () => const VerifyView(),
      binding: VerifyBinding(),
    ),
    GetPage(
      name: _Paths.TERMS_CONDITIONS,
      page: () => const TermsAndConditionsView(),
      binding: TermsConditionsBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT,
      page: () => const AboutView(),
      binding: AboutBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_SETUP,
      page: () => const ProfileSetupView(),
      binding: ProfileSetupBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_SETTINGS,
      page: () => const ProfileSettingsView(),
      binding: ProfileSettingsBinding(),
    ),
    GetPage(
      name: _Paths.USER_DETAILS,
      page: () => const UserDetailsView(),
      binding: UserDetailsBinding(),
    ),
    GetPage(
      name: _Paths.VEHICLE_DETAILS,
      page: () => const VehicleDetailsView(),
      binding: VehicleDetailsBinding(),
    ),
    GetPage(
      name: _Paths.EMERGENCY_CONTACTS,
      page: () => const EmergencyContactsView(),
      binding: EmergencyContactsBinding(),
    ),
    GetPage(
      name: _Paths.PUSH_NOTIFICATIONS,
      page: () => const PushNotificationsView(),
      binding: PushNotificationsBinding(),
    ),
    GetPage(
      name: _Paths.STUDENT_DISCOUNTS,
      page: () => const StudentDiscountsView(),
      binding: StudentDiscountsBinding(),
    ),
    GetPage(
      name: _Paths.REFER_FRIENDS,
      page: () => const ReferFriendsView(),
      binding: ReferFriendsBinding(),
    ),
    GetPage(
      name: _Paths.REFER_FRIENDS_ADD_CONTACT,
      page: () => const AddContactReferFriendsView(),
      binding: ReferFriendsBinding(),
    ),
    GetPage(
      name: _Paths.FILE_DISPUTE,
      page: () => const FileDisputeView(),
      binding: FileDisputeBinding(),
    ),
    GetPage(
      name: _Paths.RIDE_HISTORY,
      page: () => const RideHistoryView(),
      binding: RideHistoryBinding(),
    ),
    GetPage(
      name: _Paths.RIDE_DETAILS,
      page: () => const RideDetailsView(),
      binding: RideDetailsBinding(),
    ),
    GetPage(
      name: _Paths.REPORT,
      page: () => const ReportView(),
      binding: ReportBinding(),
    ),
    GetPage(
      name: _Paths.HELP_SUPPORT,
      page: () => const HelpSupportView(),
      binding: HelpSupportBinding(),
    ),
    GetPage(
      name: _Paths.FIND_RIDE,
      page: () => const FindRideView(),
      binding: FindRideBinding(),
    ),


    GetPage(
      name: _Paths.CREATE_NEW_EVENT,
      page: () => const CreateNewEventView(),
      binding: EventDetailsBinding(),
    ),



    GetPage(
      name: _Paths.EVENT_DETAILS,
      page: () => const EventDetailsView(),
      binding: CreateNewEventBinding(),
    ),

    GetPage(
      name: _Paths.ORGANIZE_CARPOOL,
      page: () => const OrganizeCarpoolView(),
      binding: OrganizeCarpoolBinding(),
    ),

    GetPage(
      name: _Paths.GROUP_CHAT,
      page: () => const GroupChatView(),
      binding: GroupChatBinding(),
    ),

    GetPage(
      name: _Paths.GROUP_DESTINATION,
      page: () => const GroupDestinationView(),
      binding: GroupDestinationBinding(),
    ),


    GetPage(
      name: _Paths.MATCHING_RIDES,
      page: () => const MatchingRidesView(),
      binding: MatchingRidesBinding(),
    ),
    GetPage(
      name: _Paths.DRIVER_DETAILS,
      page: () => const DriverDetailsView(),
      binding: DriverDetailsBinding(),
    ),
    GetPage(
      name: _Paths.RIDER_PROFILE_SETUP,
      page: () => const RiderProfileSetupView(),
      binding: RiderProfileSetupBinding(),
    ),
    GetPage(
      name: _Paths.RIDER_MY_RIDE_REQUEST,
      page: () => const RiderMyRideRequestView(),
      binding: RiderMyRideRequestBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.PASSWORD_CHANGED,
      page: () => const PasswordChanged(),
      binding: PasswordChangedBinding(),
    ),
    GetPage(
      name: _Paths.MY_RIDES_DETAILS,
      page: () => const MyRidesDetailsView(),
      binding: MyRidesDetailsBinding(),
    ),
    GetPage(
      name: _Paths.MY_RIDES_PAGE,
      page: () => const MyRidesPageView(),
      binding: MyRidesPageBinding(),
    ),
    GetPage(
      name: _Paths.RIDER_MY_RIDES_SEND_DETAILS,
      page: () => const RiderMyRidesSendDetailsView(),
      binding: RiderMyRidesSendDetailsBinding(),
    ),
    GetPage(
      name: _Paths.RIDER_MY_RIDES_CONFIRM_DETAILS,
      page: () => const RiderMyRidesConfirmDetailsView(),
      binding: RiderMyRidesConfirmDetailsBinding(),
    ),
    GetPage(
      name: _Paths.RIDER_CONFIRMED_RIDE_DETAILS,
      page: () => const RiderConfirmedRideDetailsView(),
      binding: RiderConfirmedRideDetailsBinding(),
    ),
    GetPage(
      name: _Paths.START_RIDE,
      page: () => const StartRideView(),
      binding: StartRideBinding(),
    ),
    GetPage(
      name: _Paths.POST_RIDE_STEP_ONE,
      page: () => const PostRideStepOneView(),
      binding: PostRideStepOneBinding(),
    ),
    GetPage(
      name: _Paths.MY_RIDES_RECURRING_DETAILS,
      page: () => const MyRidesRecurringDetailsView(),
      binding: MyRidesRecurringDetailsBinding(),
    ),
    GetPage(
      name: _Paths.RATING_DRIVER_SIDE,
      page: () => const RatingDriverSideView(),
      binding: RatingDriverSideBinding(),
    ),
    GetPage(
      name: _Paths.RATING_RIDER_SIDE,
      page: () => const RatingRiderSideView(),
      binding: RatingRiderSideBinding(),
    ),
    GetPage(
      name: _Paths.RIDER_START_RIDE_MAP,
      page: () => const RiderStartRideMapView(),
      binding: RiderStartRideMapBinding(),
    ),
    GetPage(
      name: _Paths.SUBMIT_DISPUTE,
      page: () => const SubmitDisputeView(),
      binding: SubmitDisputeBinding(),
    ),
    GetPage(
      name: _Paths.POST_RIDE_STEP_TWO,
      page: () => const PostRideStepTwoView(),
      binding: PostRideStepTwoBinding(),
    ),
    GetPage(
      name: _Paths.POST_RIDE_STEP_THREE,
      page: () => const PostRideStepThreeView(),
      binding: PostRideStepThreeBinding(),
    ),
    GetPage(
      name: _Paths.MAP_DRIVER_CONFIRM_REQUEST,
      page: () => const MapDriverConfirmRequestView(),
      binding: MapDriverConfirmRequestBinding(),
    ),
    GetPage(
      name: _Paths.MAP_DRIVER_SEND_REQUEST,
      page: () => const MapDriverSendRequestView(),
      binding: MapDriverSendRequestBinding(),
    ),
    GetPage(
      name: _Paths.VERIFICATION_DONE,
      page: () => const VerificationDoneView(),
      binding: VerificationDoneBinding(),
    ),
    GetPage(
      name: _Paths.POLICY_CANCELLATION,
      page: () => const PolicyCancellationView(),
      binding: PolicyCancellationBinding(),
    ),
    GetPage(
      name: _Paths.POLICY_PRIVACY,
      page: () => const PolicyPrivacyView(),
      binding: PolicyPrivacyBinding(),
    ),
    GetPage(
      name: _Paths.WALLET,
      page: () => const WalletView(),
      binding: WalletBinding(),
    ),
    GetPage(
      name: _Paths.WALLET_ADD_MONEY,
      page: () => const WalletAddMoneyView(),
      binding: WalletAddMoneyBinding(),
    ),
    GetPage(
      name: _Paths.WALLET_TO_BANK_ACC,
      page: () => const WalletToBankAccView(),
      binding: WalletToBankAccBinding(),
    ),
    GetPage(
      name: _Paths.TRANSACTION_HISTORY,
      page: () => const TransactionHistoryView(),
      binding: TransactionHistoryBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_METHOD,
      page: () => const PaymentMethodView(),
      binding: PaymentMethodBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT,
      page: () => const PaymentView(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: _Paths.PAYNOW,
      page: () => const PayNowView(),
      binding: PayNowBinding(),
    ),
    GetPage(
      name: _Paths.ADD_CARD,
      page: () => const AddCardView(),
      binding: AddCardBinding(),
    ),
    GetPage(
      name: _Paths.ADD_BANK_DETAILS,
      page: () => const AddBankDetailsView(),
      binding: AddBankDetailsBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_ADDRESS,
      page: () => const SearchAddressView(),
      binding: SearchAddressBinding(),
    ),
    GetPage(
      name: _Paths.POST_RIDE_STEP_FOUR,
      page: () => const PostRideStepFourView(),
      binding: PostRideStepFourBinding(),
    ),
    GetPage(
      name: _Paths.MAP_RIDER_CONFIRM_REQUEST,
      page: () => const MapRiderConfirmRequestView(),
      binding: MapRiderConfirmRequestBinding(),
    ),
    GetPage(
      name: _Paths.MAP_RIDER_SEND_REQUEST,
      page: () => const MapRiderSendRequestView(),
      binding: MapRiderSendRequestBinding(),
    ),
    GetPage(
      name: _Paths.VEHICLE_SETUP,
      page: () => const VehicleSetupView(),
      binding: VehicleSetupBinding(),
    ),
    GetPage(
      name: _Paths.WEB_ADD_PAY,
      page: () => const WebAddPayView(),
      binding: WebAddPayBinding(),
    ),
    GetPage(
      name: _Paths.ADD_GIFT,
      page: () => const AddGiftView(),
      binding: AddGiftBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_WITH_EXPERTS,
      page: () => const ChatWithExpertsView(),
      binding: ChatWithExpertsBinding(),
    ),
    GetPage(
      name: _Paths.WEB_ADD_TO_BANK,
      page: () => const WebAddToBankView(),
      binding: WebAddToBankBinding(),
    ),
    GetPage(
      name: _Paths.ARCHIVED,
      page: () => const ArchivedView(),
      binding: ArchivedBinding(),
    ),
    GetPage(
      name: _Paths.LANGUAGE,
      page: () => const LanguageView(),
      binding: LanguageBinding(),
    ),
    GetPage(
      name: _Paths.MY_RIDES_EDIT,
      page: () => const MyRidesEditView(),
      binding: MyRidesEditBinding(),
    ),
    GetPage(
      name: _Paths.PREVIOUS_RIDES,
      page: () => const PreviousRidesView(),
      binding: PreviousRidesBinding(),
    ),
    GetPage(
      name: _Paths.PREV_POSTED,
      page: () => const PrevPostedView(),
      binding: PrevPostedBinding(),
    ),
  ];
}
