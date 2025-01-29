import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:iss_app/model/position_response.dart';
import 'package:iss_app/service/repositories/api_call.dart';

class HomeViewModel extends ChangeNotifier {
  final ApiCall? apiCall;

  HomeViewModel({required this.apiCall});
  var isLoading = false;
  String lat = "N/A";
  String long = "N/A";
  String lastUtcTime = "N/A";
  String lastLocalTime = "N/A";
  String countryName = "N/A";
  int countdown = 60;
  Timer? _timer;

  Future<void> getPosition() async {
    isLoading = true;
    notifyListeners();
    try {
      PositionResponse? positionResponse = await apiCall?.getPosition();
      print('Position: ${positionResponse?.toJson()}');
      lat = positionResponse?.issPosition?.latitude ?? "N/A";
      long = positionResponse?.issPosition?.longitude ?? "N/A";
      double la = double.parse(lat);
      double lng = double.parse(long);
      await getAddressFromLatLng(la, lng);
      DateTime utcTime = DateTime.fromMillisecondsSinceEpoch(positionResponse?.timestamp ?? 0 * 1000, isUtc: true);
      lastUtcTime = utcTime.toString();
      DateTime localTime = DateTime.fromMillisecondsSinceEpoch(positionResponse?.timestamp ?? 0 * 1000);
      String formattedDateTime = lastLocalTime = localTime.toString();
      notifyListeners();
    } catch (e) {
      throw e;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getAddressFromLatLng(double lat, double lng) async {
    print('Address: $lat,$lng');
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        if (place.country != null) {
          countryName = place.country ?? "N/A";
          notifyListeners();

          print('Address: ${place.country}');
        } else {
          countryName = "Sea";
        }
      } else {
        countryName = "Sea";
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  // Start the countdown timer
  void startTimer() {
    stopTimer(); // Stop any existing timer
    countdown = 60; // Reset countdown
    notifyListeners();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        countdown--;
        notifyListeners();
      } else {
        stopTimer();
        recallApiAndRestartTimer();
      }
    });
  }

  // Function to recall the API and restart the timer
  void recallApiAndRestartTimer() async {
    await getPosition(); // Call the API
    startTimer(); // Restart the timer after the API call is complete
  }

  // Stop the timer
  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }
}
