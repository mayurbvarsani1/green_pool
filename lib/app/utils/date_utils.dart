import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';

class DateTimeUtils {
  static String formatTime(DateTime timestamp) {
    final localTime = timestamp.toLocal(); // Convert to local time zone

    return DateFormat.jm().format(localTime);
  }

  static String formatDate(DateTime timestamp) {
    final localTimestamp = timestamp.toLocal(); // Convert to local time zone

    return DateFormat('dd MMM yyyy').format(localTimestamp);
  }

  static String formatDateddMMMyyyy(String timestamp) {
    if (timestamp.isEmpty) {
      return "";
    }

    try {
      DateTime utcDateTime = DateTime.parse(timestamp);
      DateTime localDateTime = utcDateTime.toLocal();
      String formattedLocalDateTime =
          DateFormat('dd MMM yyyy').format(localDateTime);

      return formattedLocalDateTime;
    } catch (e) {
      debugPrint("INVALID DATE FORMAT: $e");
      return "";
    }
  }

  static bool isToday(DateTime timestamp) {
    final dateToCheck = timestamp.toLocal();
    DateTime now = DateTime.now();
    return dateToCheck.year == now.year &&
        dateToCheck.month == now.month &&
        dateToCheck.day == now.day;
  }

  static String getTimeAMPM(String date) {
    if (date.isEmpty) return '00:00';

    try {
      DateTime dateTime;
      // Check if the input contains only time (HH:mm)
      if (RegExp(r'^\d{1,2}:\d{2}$').hasMatch(date)) {
        dateTime = DateFormat('HH:mm').parse(date); // Parse time-only string
      } else {
        dateTime = DateTime.parse(date); // Parse full date-time string
      }
      return DateFormat('h:mm a').format(dateTime); // Format as AM/PM
    } catch (e) {
      return 'Invalid Time';
    }
  }

  static String getDateFormat(String time) {
    var outputDate = "";
    if (time != "") {
      try {
        var combinedDateUtc = convertCombinedUtcToLocal(time);
        outputDate =
            formatDate(DateTime.parse(combinedDateUtc.split("T").first))
                .toString();
      } catch (e) {
        debugPrint("INVALID DATE FORMAT: $e");
      }
    }
    return outputDate;
  }

  static String getTime(var mnow) {
    var outputDate = "";
    if (mnow != null) {
      try {
        var datetime = DateTime.parse(mnow);
        var localDate = datetime.toLocal();

        var outputFormat = DateFormat('HH:mm');
        outputDate = outputFormat.format(localDate);
      } catch (e) {
        debugPrint("INVALID DATE FORMAT: $e");
      }
    }

    return outputDate;
  }

  static String format24hrTime(TimeOfDay time, context) {
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    String formattedTime =
        localizations.formatTimeOfDay(time, alwaysUse24HourFormat: false);
    return formattedTime;
  }

  static String convertCombinedToGmt(String combinedDateTime) {
    if (combinedDateTime.isEmpty) {
      return "";
    }

    try {
      var inputFormat = DateFormat("yyyy-MM-dd'T'hh:mm a");
      var localDateTime = inputFormat.parse(combinedDateTime);
      var gmtDateTime = localDateTime.toUtc();

      // var outputFormat = DateFormat('yyyy-MM-ddTHH:mm');
      var outputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");

      return outputFormat.format(gmtDateTime);
    } catch (e) {
      debugPrint("INVALID DATE FORMAT: $e");
      return "";
    }
  }

  static String convertCombinedUtcToLocal(String utcTimeString) {
    if (utcTimeString.isEmpty) {
      return "";
    }

    try {
      var inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm");

      var utcDateTime = inputFormat.parseUtc(utcTimeString);
      var localDateTime = utcDateTime.toLocal();

      var outputFormat = DateFormat("yyyy-MM-dd'T'hh:mm a");

      return outputFormat.format(localDateTime);
    } catch (e) {
      debugPrint("INVALID DATE FORMAT: $e");
      return "";
    }
  }

  static String convertLocalTimeToGmt(String localTimeString) {
    if (localTimeString.isEmpty) {
      return "";
    }

    try {
      // Parse the local time string to a DateTime object
      var localDateTime = DateFormat('HH:mm').parse(localTimeString);

      // Convert the local DateTime to UTC
      var gmtDateTime = localDateTime.toUtc();

      // Format the GMT DateTime object to a string
      var outputFormat = DateFormat('HH:mm');
      return outputFormat.format(gmtDateTime);
    } catch (e) {
      debugPrint("INVALID DATE FORMAT: $e");
      return "";
    }
  }

  static String convertUtcToLocal(String utcTimeString) {
    //out put format 1:30 PM
    if (utcTimeString.isEmpty) {
      return "00:00";
    }

    try {
      // Parse the UTC time string to a DateTime object
      var utcDateTime =
          DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parseUtc(utcTimeString);

      // Convert the UTC DateTime to local time
      var localDateTime = utcDateTime.toLocal();

      // Format the local DateTime object to a string
      var outputFormat = DateFormat('hh:mm a');
      return outputFormat.format(localDateTime);
    } catch (e) {
      debugPrint("INVALID DATE FORMAT: $e");
      return "00:00";
    }
  }

  static bool isAfterCurrentTime(String inputTime) {
    // Parse the input time
    DateFormat inputFormat = DateFormat('h:mm a');
    DateTime inputDateTime = inputFormat.parse(inputTime);

    // Get the current local time
    DateTime now = DateTime.now();

    // Compare only the hour and minute
    if (inputDateTime.hour > now.hour) {
      return true;
    } else if (inputDateTime.hour == now.hour &&
        inputDateTime.minute >= now.minute) {
      return true;
    }
    return false;
  }



  static bool isAfterOneHourTime(String inputTime) {
    // Parse the input time
    DateFormat inputFormat = DateFormat('h:mm a');
    DateTime inputDateTime = inputFormat.parse(inputTime);

    // Get the current local time
    DateTime now = DateTime.now().add(1.hours);

    // Compare only the hour and minute
    if (inputDateTime.hour > now.hour) {
      return true;
    } else if (inputDateTime.hour == now.hour &&
        inputDateTime.minute >= now.minute) {
      return true;
    }
    return false;
  }

  static bool checkSixMonthsDuration(String prevCancellationDate) {
    DateTime prevDateUtc = DateTime.parse(prevCancellationDate);

    DateTime prevDateLocal = prevDateUtc.toLocal();

    DateTime currentDate = DateTime.now();

    // Calculate six months ago
    DateTime sixMonthsAgo = DateTime(
      currentDate.year,
      currentDate.month - 6,
      currentDate.day,
      currentDate.hour,
      currentDate.minute,
      currentDate.second,
      currentDate.millisecond,
      currentDate.microsecond,
    );

    // Handle the case where month subtraction leads to a negative or zero month
    if (sixMonthsAgo.month <= 0) {
      sixMonthsAgo = DateTime(
        currentDate.year - 1,
        sixMonthsAgo.month + 12,
        currentDate.day,
        currentDate.hour,
        currentDate.minute,
        currentDate.second,
        currentDate.millisecond,
        currentDate.microsecond,
      );
    }

    return prevDateLocal.isAfter(sixMonthsAgo);
  }

  static String getArrivalTimeOfDriver(DateTime rideDateTime) {
    DateTime now = DateTime.now();
    final Duration diff = rideDateTime.difference(now);
    String displayTime;

    // Define constants for duration thresholds
    const int millisecondsPerSecond = 1000;
    const int millisecondsPerMinute = 60 * millisecondsPerSecond;
    const int millisecondsPerHour = 60 * millisecondsPerMinute;
    const int millisecondsPerDay = 24 * millisecondsPerHour;
    const int millisecondsPerWeek = 7 * millisecondsPerDay;

    // Determine the format based on the difference
    if (diff.inMilliseconds < millisecondsPerMinute) {
      displayTime =
          (diff.inSeconds > 0) ? '${diff.inSeconds} seconds' : '0 seconds';
    } else if (diff.inMilliseconds < millisecondsPerHour) {
      displayTime = '${diff.inMinutes} minutes';
    } else if (diff.inMilliseconds < millisecondsPerDay) {
      displayTime = '${diff.inHours} hours';
    } else if (diff.inMilliseconds < 5 * millisecondsPerDay) {
      displayTime = '${diff.inDays} day(s)';
    } else {
      final DateFormat dateFormat = DateFormat('dd MMMM yyyy, h:mm a');
      displayTime = dateFormat.format(rideDateTime);
    }

    if (displayTime == "0 seconds") {
      displayTime = "Get ready, your ride is just seconds away.";
    } else {
      displayTime = "Ride is arriving in $displayTime";
    }

    return displayTime;
  }

  static String dateUtcToLocal(String utcTimeString) {
    if (utcTimeString.isEmpty) {
      return "";
    }

    try {
      // Parse the UTC time string to a DateTime object
      var utcDateTime =
          DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parseUtc(utcTimeString);

      // Convert the UTC DateTime to local time
      var localDateTime = utcDateTime.toLocal();

      // Format the local DateTime object to a string
      var outputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
      return outputFormat.format(localDateTime);
    } catch (e) {
      debugPrint("INVALID DATE FORMAT: $e");
      return "";
    }
  }

  static String dayDateMonthYearTime(String dateString) {
    DateTime dt;

    try {
      // Try parsing ISO 8601 format 2024-09-16T08:00:00.000Z
      dt = DateTime.parse(dateString).toLocal();
    } catch (e) {
      // If parsing fails, assume it's in "MM/dd/yyyy, h:mm:ss a" format //"Fri, 23rd Sept 2022 (10:30)"
      dt = DateFormat('MM/dd/yyyy, h:mm:ss a').parse(dateString);
    }

    String formattedDate = _formatDateWithSuffix(dt);
    String time = DateFormat('HH:mm').format(dt);

    return '$formattedDate, $time';
  }

  static String dateMonthYear(String dateString) {
    DateTime dt;

    try {
      // Try parsing ISO 8601 format 2024-09-16T08:00:00.000Z
      dt = DateTime.parse(dateString).toLocal();
    } catch (e) {
      // If parsing fails, assume it's in "MM/dd/yyyy, h:mm:ss a" format //"Fri, 23rd Sept 2022 (10:30)"
      dt = DateFormat('MM/dd/yyyy, h:mm:ss a').parse(dateString);
    }

    String formattedDate = _formatDateWithSuffix(dt);

    return formattedDate;
  }

  // Helper method to format the date with the ordinal suffix
  static String _formatDateWithSuffix(DateTime dt) {
    int dayNumber = dt.day;
    String suffix = _getOrdinalSuffix(dayNumber);
    String month = DateFormat('MMM').format(dt);
    String year = dt.year.toString();
    return '$dayNumber$suffix $month $year';
  }

  static String _getOrdinalSuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}

/*static Future<String> calculateDistance({
    required double startLat,
    required double startLong,
    required double endLat,
    required double endLong,
  }) async {
    GoogleMapsDirections directions =
        GoogleMapsDirections(apiKey: Endpoints.googleApiKey);
    DirectionsResponse response = await directions.directionsWithLocation(
      Location(lat: startLat, lng: startLong),
      Location(lat: endLat, lng: endLong),
      travelMode: TravelMode.driving,
    );

    if (response.isOkay) {
      final distanceInMeters = response.routes.first.legs.first.distance;
      // Convert distance from meters to kilometers
      //final distanceInKilometers = distanceInMeters / 1000.0;
      return distanceInMeters.text.toString();
    } else {
      return "0"; // Return a double value for consistency
    }
  }*/