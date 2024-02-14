import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rovertaxi/Utilities/res/color.dart';

import '../../Utilities/res/Assets.dart';

class BottomView extends StatefulWidget {
  final LatLng currentLatLng;
  const BottomView({super.key, required this.currentLatLng});

  @override
  State<BottomView> createState() => _BottomViewState();
}

class _BottomViewState extends State<BottomView> {
  late GoogleMapController googleMapController;
  Set<Marker> markersList = {};
  late BitmapDescriptor customIcon;
  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(28.457523, 77.026344), zoom: 14);

  void init() {
    super.initState();
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(5, 5)), Assets.assetsCarIcon)
        .then((d) {
      customIcon = d;
    });
    markersList.clear();
    markersList.add(Marker(
        markerId: const MarkerId('currentLocation'),
        icon: customIcon,
        position: widget.currentLatLng));
    googleMapController
        .animateCamera(CameraUpdate.newLatLngZoom(widget.currentLatLng, 10.0));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My Location',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            color: AppColors.primaryBackgroundColor,
            child: GoogleMap(
              mapType: MapType.normal,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              initialCameraPosition: initialCameraPosition,
              markers: markersList,
              onMapCreated: (GoogleMapController controller) {
                googleMapController = controller;
              },
            ),
          )
        ],
      ),
    );
  }
}
