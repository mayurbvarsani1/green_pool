import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/post_ride_model.dart';
import 'package:green_pool/app/services/dialog_helper.dart';
import 'package:green_pool/app/services/snackbar.dart';
import 'package:intl/intl.dart';

import '../../../routes/app_pages.dart';
import '../../../services/colors.dart';
import '../../../utils/date_utils.dart';
import '../../home/controllers/home_controller.dart';

class PostRideStepTwoController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final Rx<PostRideModel> postRideModel = PostRideModel().obs;
  var prevRideData = PostRideModel().obs;

  RxBool isPinkMode = Get.find<HomeController>().isPinkModeOn;
  RxInt tabIndex = 0.obs;
  TextEditingController selectedDate = TextEditingController();
  TextEditingController dateForRecurringRide = TextEditingController();
  TextEditingController formattedOneTimeDate = TextEditingController();
  TextEditingController selectedTime = TextEditingController();
  TextEditingController selectedReturnDate = TextEditingController();
  TextEditingController formattedReturnDate = TextEditingController();
  TextEditingController selectedReturnTime = TextEditingController();
  TextEditingController selectedRecurringTime = TextEditingController();

  RxBool isReturn = false.obs;
  RxBool isActiveCarpoolButton = false.obs;
  final RxInt count = 1.obs;
  final pickerColor = Get.find<HomeController>().isPinkModeOn.value
      ? ColorUtil.kPrimaryPinkMode
      : ColorUtil.kPrimary01;

  //for Days of week
  RxBool isMonday = false.obs; //1
  RxBool isTuesday = false.obs; //2
  RxBool isWednesday = false.obs; //3
  RxBool isThursDay = false.obs; //4
  RxBool isFriday = false.obs; //5
  RxBool isSaturday = false.obs; //6
  RxBool isSunday = false.obs; //7
  List<int?>? daysOfWeek = <int>[].obs;

  //luggage allowance
  RxBool noLuggage = false.obs;
  RxBool smallLuggage = false.obs;
  RxBool mediumLuggage = false.obs;
  RxBool largeLuggage = false.obs;
  RxString selectedCHIP = 'No'.obs;
  final RxString luggageWeight = 'No'.obs;

  //amenities
  RxBool appreciatesConversation = false.obs;
  RxBool enjoysMusic = false.obs;
  RxBool smokeFree = false.obs;
  RxBool petFriendly = false.obs;
  RxBool winterTires = false.obs;
  RxBool coolingOrHeating = false.obs;
  RxBool babySeat = false.obs;
  RxBool heatedSeats = false.obs;

  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      tabIndex.value = tabController.index; // Sync TabController with RxInt
    });
    _setInitialTimeAndDate();
    setActiveStateCarpoolSchedule();
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
  }

  void setTabIndex(int index) {
    tabIndex.value = index;
    tabController.animateTo(index); // Ensure tab UI updates
    setActiveStateCarpoolSchedule();
  }

  void addDays(int heading) {
    if (daysOfWeek == null) return;

    if (!daysOfWeek!.contains(heading)) {
      daysOfWeek!.add(heading);
      daysOfWeek!.sort();
    }
  }

  void removeDays(int heading) {
    daysOfWeek?.remove(heading);
  }

  void _setInitialTimeAndDate() {
    final now = DateTime.now();
    final nextHour = now.add(const Duration(hours: 1));

    final timeOfDay = TimeOfDay(hour: nextHour.hour, minute: 0);
    final formattedTime = DateFormat('hh:mm a').format(DateTime(
      now.year,
      now.month,
      now.day,
      timeOfDay.hour,
      timeOfDay.minute,
    ));

    selectedTime.text = formattedTime;
    final pickedDate = DateTime.now();
    selectedDate.text = pickedDate.toIso8601String();
    dateForRecurringRide.text = selectedDate.text;
    formattedOneTimeDate.text =
        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    postRideModel.value = Get.arguments;
  }

  Future<void> setDate(BuildContext context) async {
    DateTime? pickedDate = Platform.isIOS
        ? await DialogHelper.cupertinoDatePicker(context, DateTime.now(),
            DateTime.now().add(const Duration(days: 3 * 30)), DateTime.now())
        : await showDatePicker(
            context: context,
            builder: _pickerTheme,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 3 * 30)),
            initialDate: DateTime.now(),
          );

    if (pickedDate != null) {
      String formattedDate = pickedDate.toIso8601String();
      selectedDate.text = formattedDate;
      selectedTime.clear();
      formattedOneTimeDate.text =
          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      setActiveStateCarpoolSchedule();
    }
  }

  Future<void> setTime(BuildContext context) async {
    TimeOfDay? pickedTime = Platform.isIOS
        ? await DialogHelper.cupertinoTimePicker(context)
        : await showTimePicker(
            context: context,
            builder: _pickerTheme,
            initialTime: TimeOfDay.now(),
            initialEntryMode: TimePickerEntryMode.dial,
          );
    if (pickedTime != null) {
      // Use MaterialLocalizations to format the time in 24-hour format
      final MaterialLocalizations localizations =
          MaterialLocalizations.of(context);
      String formattedTime = localizations.formatTimeOfDay(pickedTime,
          alwaysUse24HourFormat: false);

      if (selectedDate.text.isNotEmpty) {
        if (DateTimeUtils.isToday(DateTime.parse(selectedDate.text))) {
          if (DateTimeUtils.isAfterCurrentTime(formattedTime)) {
            selectedTime.text = formattedTime;

            setActiveStateCarpoolSchedule();
          } else {
            showMySnackbar(msg: "Please select a valid time");
            selectedTime.clear();
          }
        } else {
          selectedTime.text = formattedTime;
          setActiveStateCarpoolSchedule();
        }
        debugPrint("selectedTime.text=${selectedTime.text}");
      } else {
        showMySnackbar(msg: "Please select a date");
      }
    }
  }

  Future<void> setReturnDate(BuildContext context) async {
    DateTime? pickedDate = Platform.isIOS
        ? await DialogHelper.cupertinoDatePicker(context, DateTime.now(),
            DateTime.now().add(const Duration(days: 3 * 30)), DateTime.now())
        : await showDatePicker(
            context: context,
            builder: _pickerTheme,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 3 * 30)),
            initialDate: DateTime.now());

    if (pickedDate != null) {
      String formattedDate = pickedDate.toIso8601String();
      if (!DateTimeUtils.isToday(DateTime.parse(selectedDate.text)) &&
          DateTimeUtils.isToday(DateTime.parse(formattedDate))) {
        showMySnackbar(msg: "Please select a valid date");
      } else {
        selectedReturnDate.text = formattedDate;
        debugPrint("SELECTED RETURN DATE ${selectedReturnDate.text}");
        selectedReturnTime.clear();
        formattedReturnDate.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
        setActiveStateCarpoolSchedule();
      }
    }
  }

  Future<void> setReturnTime(BuildContext context) async {
    TimeOfDay? pickedTime = Platform.isIOS
        ? await DialogHelper.cupertinoTimePicker(context)
        : await showTimePicker(
            context: context,
            builder: _pickerTheme,
            initialTime: TimeOfDay.now(),
            initialEntryMode: TimePickerEntryMode.dial,
          );

    if (pickedTime != null) {
      final MaterialLocalizations localizations =
          MaterialLocalizations.of(context);
      String formattedTime = localizations.formatTimeOfDay(pickedTime,
          alwaysUse24HourFormat: false);
      if (DateTimeUtils.isToday(
          DateTime.parse(selectedReturnDate.value.text))) {
        // If the date is today, validate the return time
        if (validateReturnTime(formattedTime)) {
          selectedReturnTime.text = formattedTime.toString();
          setActiveStateCarpoolSchedule();
        } else {
          showMySnackbar(
              msg:
                  "Please ensure that the return time is a minimum of 2 hours later than the scheduled time.");
        }
      } else {
        selectedReturnTime.text = formattedTime.toString();
        setActiveStateCarpoolSchedule();
      }
    }
  }

  Future<void> setRecurringTime(BuildContext context) async {
    TimeOfDay? pickedTime = Platform.isIOS
        ? await DialogHelper.cupertinoTimePicker(context)
        : await showTimePicker(
            context: context,
            builder: _pickerTheme,
            initialTime: TimeOfDay.now(),
            initialEntryMode: TimePickerEntryMode.dial,
          );

    if (pickedTime != null) {
      // Use MaterialLocalizations to format the time in 24-hour format
      final MaterialLocalizations localizations =
          MaterialLocalizations.of(context);
      String formattedTime = localizations.formatTimeOfDay(pickedTime,
          alwaysUse24HourFormat: false);
      selectedRecurringTime.text = formattedTime;
      setActiveStateCarpoolSchedule();

      /*if (GpUtil.isAfterCurrentTime(formattedTime)) {
        selectedRecurringTime.text = formattedTime;
        setActiveStateCarpoolSchedule();
      } else {
        showMySnackbar(msg: "Please select a valid time");
        selectedRecurringTime.clear();
      }*/
    }
  }

  setActiveStateCarpoolSchedule() {
    if (tabIndex.value == 0
        ? isReturn.value
            ? (formattedOneTimeDate.value.text.isNotEmpty &&
                selectedTime.value.text.isNotEmpty &&
                selectedReturnDate.value.text.isNotEmpty &&
                selectedReturnTime.value.text.isNotEmpty)
            : (formattedOneTimeDate.value.text.isNotEmpty &&
                selectedTime.value.text.isNotEmpty)
        : (daysOfWeek!.isNotEmpty && selectedRecurringTime.text.isNotEmpty)) {
      isActiveCarpoolButton.value = true;
    } else {
      isActiveCarpoolButton.value = false;
    }
  }

  void increment() {
    //handles available seat number
    if (count.value <= 9) {
      count.value++;
    }
  }

  void decrement() {
    //handles available seat number
    if (count.value >= 2) {
      count.value--;
    }
  }

  moveToPricingView() {
    final combinedDateTime = "${selectedDate.text.toString().split("T").first}T${selectedTime.text}";

    final combinedDateTimeUTC =
        DateTimeUtils.convertCombinedToGmt(combinedDateTime);

    final date = combinedDateTimeUTC.split("T").first;
    final time = combinedDateTimeUTC;
    debugPrint("date=>${date}");
    debugPrint("time=>${time}");
    final combinedReturnDateTime =
        "${selectedReturnDate.text.toString().split("T").first}T${selectedReturnTime.text}";

    final combinedReturnDateTimeUTC =
        DateTimeUtils.convertCombinedToGmt(combinedReturnDateTime);

    final returnDate = combinedReturnDateTimeUTC.split("T").first;
    final returnTime = combinedReturnDateTimeUTC;

    final combinedRecurringTime =
        "${dateForRecurringRide.text.toString().split("T").first}T${selectedRecurringTime.text}";
    final recurringTime =
        DateTimeUtils.convertCombinedToGmt(combinedRecurringTime);

    Get.toNamed(Routes.POST_RIDE_STEP_THREE,
        arguments: PostRideModel(
          ridesDetails: PostRideModelRidesDetails(
            origin: PostRideModelRidesDetailsOrigin(
                name: postRideModel.value.ridesDetails?.origin?.name,
                latitude: postRideModel.value.ridesDetails?.origin?.latitude,
                longitude: postRideModel.value.ridesDetails?.origin?.longitude),
            destination: PostRideModelRidesDetailsDestination(
                name: postRideModel.value.ridesDetails?.destination?.name,
                latitude:
                    postRideModel.value.ridesDetails?.destination?.latitude,
                longitude:
                    postRideModel.value.ridesDetails?.destination?.longitude),
            stops: [
              PostRideModelRidesDetailsStops(
                  name: postRideModel.value.ridesDetails?.stops?[0].name,
                  latitude:
                      postRideModel.value.ridesDetails?.stops?[0].latitude,
                  longitude:
                      postRideModel.value.ridesDetails?.stops?[0].longitude),
              PostRideModelRidesDetailsStops(
                  name: postRideModel.value.ridesDetails?.stops?[1].name,
                  latitude:
                      postRideModel.value.ridesDetails?.stops?[1].latitude,
                  longitude:
                      postRideModel.value.ridesDetails?.stops?[1].longitude),
            ],
            tripType: tabIndex.value == 0 ? "oneTime" : "recurring",
            date: tabIndex.value == 0
                ? date
                : recurringTime.toString().split("T").first,
            time: tabIndex.value == 1 ? recurringTime : time,
            recurringTrip: PostRideModelRidesDetailsRecurringTrip(
                recurringTripDays: tabIndex.value == 1 ? daysOfWeek : []),
            seatAvailable: count.value,
            preferences: PostRideModelRidesDetailsPreferences(
                luggageType: selectedCHIP.value,
                other: PostRideModelRidesDetailsPreferencesOther(
                  AppreciatesConversation: appreciatesConversation.value,
                  EnjoysMusic: enjoysMusic.value,
                  SmokeFree: smokeFree.value,
                  PetFriendly: petFriendly.value,
                  WinterTires: winterTires.value,
                  CoolingOrHeating: coolingOrHeating.value,
                  BabySeat: babySeat.value,
                  HeatedSeats: heatedSeats.value,
                )),
            returnTrip: PostRideModelRidesDetailsReturnTrip(
              isReturnTrip: tabIndex.value != 1 ? isReturn.value : false,
              returnDate: tabIndex.value != 1 ? returnDate : "",
              returnTime: tabIndex.value != 1 ? returnTime : "",
            ),
          ),
        ));
  }

  bool validateReturnTime(String returnTime) {
    try {
      // Parse the input time strings
      DateFormat format = DateFormat("hh:mm a");
      DateTime parsedReturnTime = format.parse(returnTime);
      DateTime scheduledTime = format.parse(selectedTime.value.text);

      // Combine the date parts from current date and the time parts from parsed times
      DateTime now = DateTime.now();
      DateTime scheduledDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        scheduledTime.hour,
        scheduledTime.minute,
      );
      DateTime returnDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        parsedReturnTime.hour,
        parsedReturnTime.minute,
      );

      // Add 2 hours to the scheduled time
      DateTime validTime =
          scheduledDateTime.add(const Duration(hours: 1, minutes: 59));

      // Check if the return time is at least 2 hours more than the scheduled time
      return returnDateTime.isAfter(validTime);
    } catch (e) {
      debugPrint("Error parsing time string: $e");
      return false;
    }
  }

  Widget _pickerTheme(BuildContext context, Widget? child) {
    return Theme(
      data: ThemeData(
        primaryColor: Get.find<HomeController>().isPinkModeOn.value
            ? ColorUtil.kPrimaryPinkMode
            : ColorUtil.kPrimary01,
        colorScheme: ColorScheme.light(
          primary: Get.find<HomeController>().isPinkModeOn.value
              ? ColorUtil.kPrimaryPinkMode
              : ColorUtil.kPrimary01,
          surface: Colors.white,
          onPrimary: Colors.white,
          secondary: Get.find<HomeController>().isPinkModeOn.value
              ? ColorUtil.kPrimaryPinkMode
              : ColorUtil.kPrimary01,
        ),
        dialogBackgroundColor: Colors.white,
      ),
      child: child!,
    );
  }

  /*void setPrevRideData() {
    // Retrieve previous ride data from storage
    final storageService = Get.find<GetStorageService>();
    final prevRide = storageService.getPostRideData() ?? PostRideModel();
    prevRideData.value = prevRide;
    final rideDetails = prevRideData.value.ridesDetails;

    //before setting date and time it should check if it is past the current time

    // Set various sections of the ride data
    _setRideTime(rideDetails);
    _setReturnTrip(rideDetails);
    _setRidePreferences(rideDetails);
    _setRecurringTrip(rideDetails);

    // Validate active state for the next button
    setActiveStateCarpoolSchedule();
  }

  void _setRideTime(PostRideModelRidesDetails? rideDetails) {
    // Use a default time if none is provided
    final now = DateTime.now();
    const defaultRideTime = "2025-03-04T09:39:00.000Z";
    final actualTime = rideDetails?.time ?? defaultRideTime;
    final actualTimeUtc = DateTimeUtils.dateUtcToLocal(actualTime);
    final rideTimeUtc = rideDetails?.time ?? defaultRideTime;
    final rideTimeLocal = DateTimeUtils.convertUtcToLocal(rideTimeUtc);
    if (DateTime.parse(actualTimeUtc).isBefore(now)) {
      debugPrint("Ride time is in the past");
    } else {
      selectedTime.text = rideTimeLocal;
    }
  }

  void _setReturnTrip(PostRideModelRidesDetails? rideDetails) {
    const defaultReturnDate = "2024-01-30T07:00:17.320+00:00";
    final returnTrip = rideDetails?.returnTrip;
    isReturn.value = returnTrip?.isReturnTrip ?? false;

    if (isReturn.value) {
      // Parse and set the return date details
      final returnDate =
          DateTime.parse(returnTrip?.returnDate ?? defaultReturnDate);
      if (returnDate.isBefore(DateTime.now())) {
        debugPrint("Return date is in the past");
      } else {
        selectedReturnDate.text = returnDate.toIso8601String();
        formattedReturnDate.text =
            "${returnDate.day}/${returnDate.month}/${returnDate.year}";
      }

      // Set return time
      final returnTimeUtc = returnTrip?.returnTime ?? "11:00AM";
      //check if return date is today
      if (DateTimeUtils.isToday(returnDate)) {
        //if yes then check if return time is after scheduled time
        if (validateReturnTime(returnTimeUtc)) {
          selectedReturnTime.text =
              DateTimeUtils.convertUtcToLocal(returnTimeUtc);
        } else {
          showMySnackbar(
              msg:
                  "Please ensure that the return time is a minimum of 2 hours later than the scheduled time.");
        }
      } else {
        //if not directly set the return time
        selectedReturnTime.text =
            DateTimeUtils.convertUtcToLocal(returnTimeUtc);
      }
    }
  }

  void _setRidePreferences(PostRideModelRidesDetails? rideDetails) {
    const defaultLuggageType = "No";

    // Set basic preferences
    count.value = rideDetails?.seatAvailable ?? 1;
    final luggageType =
        rideDetails?.preferences?.luggageType ?? defaultLuggageType;
    selectedCHIP.value = luggageType;
    setLuggageWeight(luggageType);

    // Set additional ride preferences
    final otherPrefs = rideDetails?.preferences?.other;
    appreciatesConversation.value =
        otherPrefs?.AppreciatesConversation ?? false;
    enjoysMusic.value = otherPrefs?.EnjoysMusic ?? false;
    smokeFree.value = otherPrefs?.SmokeFree ?? false;
    petFriendly.value = otherPrefs?.PetFriendly ?? false;
    winterTires.value = otherPrefs?.WinterTires ?? false;
    coolingOrHeating.value = otherPrefs?.CoolingOrHeating ?? false;
    babySeat.value = otherPrefs?.BabySeat ?? false;
    heatedSeats.value = otherPrefs?.HeatedSeats ?? false;
  }

  void _setRecurringTrip(PostRideModelRidesDetails? rideDetails) {
    const defaultRideTime = "2025-03-04T09:39:00.000Z";

    // Determine the tab index based on trip type
    tabIndex.value = rideDetails?.tripType == "recurring" ? 1 : 0;
    tabController.animateTo(tabIndex.value);

    // Set recurring trip days
    final recurringTrip = rideDetails?.recurringTrip;
    final recurringDays = recurringTrip?.recurringTripDays ?? [];
    isMonday.value = recurringDays.contains(1);
    isTuesday.value = recurringDays.contains(2);
    isWednesday.value = recurringDays.contains(3);
    isThursDay.value = recurringDays.contains(4);
    isFriday.value = recurringDays.contains(5);
    isSaturday.value = recurringDays.contains(6);
    isSunday.value = recurringDays.contains(7);

    // Update the daysOfWeek list after clearing previous values
    daysOfWeek?.clear();
    daysOfWeek?.addAll(recurringDays);

    // Set recurring trip time using the same ride time as default
    selectedRecurringTime.text =
        DateTimeUtils.convertUtcToLocal(rideDetails?.time ?? defaultRideTime);
  }
  */

  void setLuggageWeight(String s) {
    if (selectedCHIP.value == "No") {
      luggageWeight.value = "No";
    } else if (selectedCHIP.value == "S") {
      luggageWeight.value = "5 kg";
    } else if (selectedCHIP.value == "M") {
      luggageWeight.value = "10 kg";
    } else if (selectedCHIP.value == "L") {
      luggageWeight.value = "15 kg";
    }
  }
}
