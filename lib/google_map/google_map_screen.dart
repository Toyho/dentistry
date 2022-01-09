import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dentistry/resources/colors_res.dart';
import 'package:dentistry/resources/images_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key? key}) : super(key: key);

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {

  final LatLng _kMapCenter = const LatLng(52.980137, 36.071302);
  final LatLng _kMapRandom = const LatLng(52.991285, 36.045805);

  late final CameraPosition _kInitialPosition;
  late final PolylinePoints polylinePoints;
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};

  _createPolylines() async {
    polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyAhwSD2nkIyDLsgOHxKOtt8p5Rf4V1y_e4", // Google Maps API Key
      PointLatLng(_kMapRandom.latitude, _kMapRandom.longitude),
      PointLatLng(_kMapCenter.latitude, _kMapCenter.longitude),
      travelMode: TravelMode.transit,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    PolylineId id = const PolylineId('poly');

    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );

    setState(() {
      polylines[id] = polyline;
    });
  }

  @override
  void initState() {
    super.initState();
    _kInitialPosition = CameraPosition(target: _kMapCenter, zoom: 15.0, tilt: 0, bearing: 0);
    _createPolylines();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomSheet: SafeArea(
        child: SolidBottomSheet(
          draggableBody: true,
          maxHeight: 200,
          headerBar: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16),),
              color: Colors.white,
            ),
            height: 52,
            child: Center(
              child: Container(
                height: 6,
                width: 48,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  color: ColorsRes.fromHex(ColorsRes.primaryColor)
                ),
              ),
            ),
          ),
          body: Container(
            color: Colors.white,
            height: 200,
            child: Center(
              child: Text(
                "Информация о адресе",
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          FutureBuilder(
            future: generateMarkers([_kMapCenter]),
            builder:
            (BuildContext context, AsyncSnapshot<Set<Marker>> snapshot) {
          Widget child;
          if (snapshot.hasData) {
            child = GoogleMap(
              initialCameraPosition: _kInitialPosition,
              markers: snapshot.data!,
              polylines: Set<Polyline>.of(polylines.values),
              zoomControlsEnabled: false,
            );
          } else {
            child = const Center(
              child: SizedBox(
                child: CircularProgressIndicator(),
                width: 40,
                height: 40,
              ),
            );
          }
          return child;
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03, left: 16),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, color: ColorsRes.fromHex(ColorsRes.primaryColor),),
            ),
          )
        ],
      ),
    );
  }

  Future<Set<Marker>> generateMarkers(List<LatLng> positions) async {
    List<Marker> markers = <Marker>[];
    for (final location in positions) {
      final Uint8List icon = await getBytesFromAsset(ImageRes.pinImage, 100);

      final marker = Marker(
        markerId: MarkerId(location.toString()),
        position: LatLng(location.latitude, location.longitude),
        icon: BitmapDescriptor.fromBytes(icon),
      );

      markers.add(marker);
    }

    return markers.toSet();
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
