import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:qixer/helper/extension/context_extension.dart';
import 'package:qixer/service/filter_services_service.dart';
import 'package:qixer/view/home/homepage_helper.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';

import '../home/components/home_app_bar.dart';

class HomeMapView extends StatelessWidget {
  HomeMapView({super.key});

  BitmapDescriptor? customerMarkerIcon;
  final ValueNotifier currentLocationNotifier =
      ValueNotifier(const LatLng(23.75617516773963, 90.44100487471404));
  LatLng? firstLocation;
  GoogleMapController? controller;
  // Map<PolylineId, Polyline> polylines = <PolylineId, Polyline>{};
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  PolylineId? selectedPolyline;
  LatLng? currentLocation;
  LatLng? destinationLocation;
  Stream<Position>? currentLocStream;
  Marker? currentL;

  void _onMapCreated(GoogleMapController controller) {
    debugPrint("Map got created............................".toString());
    this.controller = controller;
  }

  getMarker(BuildContext context) async {
    var markerIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(44, 44)),
        "assets/images/location_marker.png");
    final fs = Provider.of<FilterServicesService>(context, listen: false);

// {
//       'serviceId': serviceId,
//       'title': title,
//       'sellerName': sellerName,
//       'price': price,
//       'rating': rating,
//       'image': image,
//       'isSaved': false,
//       'sellerId': sellerId,
//       'lat': lat,
//       'lng': lng,
//     }
    List idList = [];
    for (var element in fs.serviceMap) {
      if (element["lat"] == null || element["lng"] == null) {
        continue;
      }
      try {
        var latLng = element["lat"].toString() + element["lng"].toString();
        // double randomLat = 23.729837;
        // double randomLng = 90.405615;
        // latLng = randomLat.toString() + ", " + randomLng.toString();
        // if (markers.containsKey(MarkerId(latLng))) {
        //   do {
        //     debugPrint("key contains $latLng".toString());
        //     final ranLatLng = getRandomCoordinates(23.729837, 90.405615, 500);
        //     randomLat = ranLatLng.first;
        //     randomLng = ranLatLng.last;
        //     latLng = randomLat.toString() + ", " + randomLng.toString();
        //   } while (idList.contains(latLng));
        // }
        final markerId = MarkerId(latLng);
        idList.add(latLng);
        debugPrint(latLng.toString());
        markers.putIfAbsent(
            markerId,
            () => Marker(
                  markerId: markerId,
                  position: LatLng(element["lat"], element["lng"]),
                  icon: markerIcon,
                  onTap: () {
                    controller?.animateCamera(CameraUpdate.newCameraPosition(
                        CameraPosition(
                            target: LatLng(element["lat"], element["lng"]),
                            zoom: 21)));
                    HomepageHelper().showServiceWindow(
                      context,
                      element["title"],
                      element["price"],
                      element["rating"],
                      element["sellerName"],
                      element["image"],
                      element["serviceId"],
                    );
                  },
                ));
        firstLocation ??= LatLng(element["lat"], element["lng"]);
        debugPrint("Marker added $latLng".toString());
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    // markers = {
    //   const MarkerId("fgs"): Marker(
    //     markerId: const MarkerId("fgs"),
    //     position: const LatLng(23.729837, 90.458692),
    //     icon: markerIcon,
    //     onTap: () {
    //       HomepageHelper().showServiceWindow(context, "title", "price",
    //           "rating", "sellerName", "imageUrl", "serviceId");
    //     },
    //   ),
    //   ),
    // };
    debugPrint(
        "Marker count is ${markers.length}...................".toString());
    markers.keys.toList().forEach((element) {
      debugPrint(element.value.toString());
    });
    return markers;
  }

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Scaffold(
      appBar: CommonHelper().appbarCommon("", context, () {
        context.popFalse;
      }),
      body: FutureBuilder(
          future: getMarker(context),
          builder: (context, snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return Center(
                child: OthersHelper().showLoading(cc.primaryColor),
              );
            }
            return GoogleMap(
              initialCameraPosition: CameraPosition(
                target: firstLocation ?? currentLocationNotifier.value,
                zoom: 21.0,
              ),
              zoomControlsEnabled: false,
              // polylines: Set<Polyline>.of(polylines.values),
              onMapCreated: _onMapCreated,
              markers: Set<Marker>.of(markers.values),
              buildingsEnabled: false,
              mapToolbarEnabled: true,
              indoorViewEnabled: false,
              liteModeEnabled: false,
              rotateGesturesEnabled: false,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,

              mapType: MapType.normal,
            );
          }),
    );
  }

  List<double> getRandomCoordinates(double originalLatitude,
      double originalLongitude, double radiusInMeters) {
    // Earth radius in meters
    const earthRadius = 6371000.0;

    // Convert radius from meters to radians
    double radiusInRadians = radiusInMeters / earthRadius;

    // Generate random angle
    double randomAngle = Random().nextDouble() * 2 * pi;

    // Calculate new latitude and longitude
    double newLatitude = originalLatitude + radiusInRadians * cos(randomAngle);
    double newLongitude =
        originalLongitude + radiusInRadians * sin(randomAngle);

    return [
      // newLatitude,
      // newLongitude,
      double.parse(newLatitude.toStringAsFixed(6)),
      double.parse(newLongitude.toStringAsFixed(6))
    ];
  }
}
