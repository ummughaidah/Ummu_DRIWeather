import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

class MapsController extends GetxController {
  TextEditingController? searchController;
  RxBool isLoading = false.obs;
  RxString cityName = 'Loading...'.obs;

  final GetStorage storage = GetStorage();
  final Completer<GoogleMapController> controllerMaps =
      Completer<GoogleMapController>();
  final RxInt navigationButtomIndex = 0.obs;

  CameraPosition? kGooglePlex;
  RxSet<Marker> markers = <Marker>{}.obs;
  RxSet<Circle> circles = <Circle>{}.obs;

  RxDouble lat1 = 0.0.obs;
  RxDouble long1 = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    searchController = TextEditingController();
    getLocation();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    searchController?.dispose();
  }

  Future<void> onMapCreated(GoogleMapController controller) async {
    print('Map created');
    if (!controllerMaps.isCompleted) {
      controllerMaps.complete(controller);
    }
  }

  getLocation() async {
    isLoading(true);
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
      }
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double lat = position.latitude;
    double long = position.longitude;

    // Reverse geocoding to get the city name
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    Placemark place = placemarks[0];

    cityName.value = place.locality ?? "Unknown City";

    lat1.value = position.latitude;
    long1.value = position.longitude;

    kGooglePlex = CameraPosition(
      target: LatLng(lat, long),
      zoom: 15,
    );

    BitmapDescriptor.defaultMarker;

    markers.add(Marker(
      markerId: const MarkerId('Marker1'),
      position: LatLng(lat, long),
      icon: BitmapDescriptor.defaultMarker,
      draggable: true,
      onTap: () {},
    ));
    isLoading(false);
  }

  // Method untuk meng-handle hasil Prediction dari pencarian tempat
  void handlePrediction(Prediction prediction) {
    // Convert lat and lng from String? to double
    double lat = double.tryParse(prediction.lat ?? '0.0') ?? 0.0;
    double lng = double.tryParse(prediction.lng ?? '0.0') ?? 0.0;

    // Update marker position
    markers.clear();
    markers.add(
      Marker(
        markerId: const MarkerId("searchResult"),
        position: LatLng(lat, lng),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );

    // Move camera to the new location
    controllerMaps.future.then((mapController) {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(lat, lng),
            zoom: 15,
          ),
        ),
      );
    });
  }

  // Method untuk menangani item click dari hasil pencarian tempat
  void handleItemClick(Prediction prediction) {
    // Update searchController text
    searchController?.text = prediction.description ?? "";
    searchController?.selection = TextSelection.fromPosition(
      TextPosition(offset: prediction.description?.length ?? 0),
    );

    // Convert lat and lng from String? to double
    double lat = double.tryParse(prediction.lat ?? '0.0') ?? 0.0;
    double lng = double.tryParse(prediction.lng ?? '0.0') ?? 0.0;

    // Update marker position
    markers.clear();
    markers.add(
      Marker(
        markerId: const MarkerId("searchResult"),
        position: LatLng(lat, lng),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );

    // Move camera to the new location
    controllerMaps.future.then((mapController) {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(lat, lng),
            zoom: 15,
          ),
        ),
      );
    });
  }
}
