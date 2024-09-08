import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

import '../controllers/maps_controller.dart';

class MapsView extends GetView<MapsController> {
  const MapsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MapsController());
    return Scaffold(body: SafeArea(
      child: Obx(
        () {
          return controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Stack(
                  children: [
                    GoogleMap(
                      mapType: MapType.terrain,
                      initialCameraPosition: controller.kGooglePlex!,
                      onMapCreated: controller.onMapCreated,
                      markers: Set<Marker>.of(controller.markers.toSet()),
                      circles: controller.circles.toSet(),
                    ),
                    Positioned(
                      top: 16,
                      left: 0,
                      right: 0,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: GooglePlaceAutoCompleteTextField(
                            textEditingController: controller.searchController!,
                            googleAPIKey:
                                "YOUR_API_KEY",
                            inputDecoration: const InputDecoration(
                              hintText: "Search here",
                              prefixIcon: Icon(Icons.search_rounded),
                              suffixIcon: Icon(
                                Icons.mic,
                                color: Colors.black,
                              ),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              fillColor: Colors.white,
                              filled: true,
                            ),
                            debounceTime: 400,
                            countries: null,
                            isLatLngRequired: true,
                            getPlaceDetailWithLatLng: (Prediction prediction) {
                              controller.handlePrediction(prediction);
                            },

                            itemClick: (Prediction prediction) {
                              controller.handleItemClick(prediction);
                            },
                            seperatedBuilder: const Divider(),
                            containerHorizontalPadding: 10,

                            // OPTIONAL// If you want to customize list view item builder
                            itemBuilder:
                                (context, index, Prediction prediction) {
                              return Container(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    const Icon(Icons.location_on),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Expanded(
                                        child:
                                            Text(prediction.description ?? ""))
                                  ],
                                ),
                              );
                            },
                            isCrossBtnShown: true,
                          ),
                        ),
                      ),
                    )
                  ],
                );
        },
      ),
    ));
  }
}
