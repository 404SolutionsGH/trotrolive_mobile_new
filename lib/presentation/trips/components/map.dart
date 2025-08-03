import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geodesy/geodesy.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:trotrolive_mobile_new/helpers/text_widgets.dart';
import 'package:trotrolive_mobile_new/helpers/widgets/cedi_widget.dart';
import '../../../helpers/animation/showup_animation.dart';
import '../../../utils/constants/color constants/colors.dart';
import '../repository/data/fetch_polylines_service.dart';

class MapDirectionScreen extends StatefulWidget {
  final double? startLat;
  final double? startLong;
  final double? desLat;
  final double? desLong;
  final String? start;
  final String? dest;
  final String? fare;
  const MapDirectionScreen({
    Key? key,
    required this.startLat,
    required this.startLong,
    required this.desLat,
    required this.desLong,
    this.start,
    this.dest,
    this.fare,
  }) : super(key: key);

  @override
  State<MapDirectionScreen> createState() => _MapDirectionScreenState();
}

class _MapDirectionScreenState extends State<MapDirectionScreen> {
  bool isLoading = true;
  LatLng initialCenter = const LatLng(0.0, 0.0);
  PolylineRemoteApiService lineService = PolylineRemoteApiService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateMapCenter().then((_) {
        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            isLoading = false;
          });
        });
      });
    });
  }

  Future<void> _updateMapCenter() async {
    if (widget.startLat != null &&
        widget.startLong != null &&
        widget.desLat != null &&
        widget.desLong != null) {
      final newCenter = LatLng(
        widget.desLat ?? 0.0,
        widget.desLong ?? 0.0,
      );
      debugPrint(
        'desLat - ${widget.desLat}, destLong -  ${widget.desLong}',
      );

      setState(() {
        initialCenter = newCenter;
      });
    } else {
      print("Error occurred while getting coordinates");
    }
  }

  List<LatLng> points = [
    const LatLng(37.7749, -122.4194),
  ];

  @override
  Widget build(BuildContext context) {
    // return BlocConsumer<LocationBloc, LocationState>(
    //   listener: (context, state) {
    //     if (state is CordinatesLoaded) {
    //     } else if (state is LocationLoading) {
    //       Center(child: CircularProgressIndicator());
    //     } else {
    //       const Center(child: Text("Failed to load location"));
    //     }
    //   },
    //   builder: (BuildContext context, state) {
    return Scaffold(
      backgroundColor: barBg,
      bottomSheet: GestureDetector(
        onTap: () {},
        child: Container(
          width: double.infinity,
          height: 280,
          decoration: const BoxDecoration(
            color: whiteColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                const SizedBox(height: 5),
                ShowUpAnimation(
                  delay: 300,
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: secondaryColor2,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 10),
                        Container(
                          height: 130,
                          width: 250,
                          child: Column(
                            children: [
                              ListTile(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                leading: Image.asset(
                                  height: 30,
                                  width: 30,
                                  'assets/pngs/place_marker_48px.png',
                                ),
                                title: headingTextMedium(
                                  context,
                                  widget.start ?? '',
                                  FontWeight.w600,
                                  13,
                                ),
                              ),
                              Divider(
                                color: iconGrey.withOpacity(0.5),
                                thickness: 0.5,
                              ),
                              ListTile(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                leading: Image.asset(
                                  height: 30,
                                  width: 30,
                                  'assets/pngs/bus_stop_48px.png',
                                ),
                                title: headingTextMedium(
                                  context,
                                  widget.dest ?? '',
                                  FontWeight.w600,
                                  13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 150,
                          width: 70,
                          child: Center(
                            child: Icon(
                              Icons.compare_arrows_outlined,
                              color: Colors.blue,
                              size: 35,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                ShowUpAnimation(
                  delay: 300,
                  child: SizedBox(
                    height: 80,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: whiteColor,
                            border: Border.all(color: primaryColorDeep),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                MingCute.time_line,
                                color: primaryColorDeep,
                                size: 25,
                              ),
                              SizedBox(height: 3),
                              headingTextMedium(
                                context,
                                '7-10',
                                FontWeight.w600,
                                12,
                                blackColor,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8),
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: whiteColor,
                            border: Border.all(
                              color: primaryColorDeep,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                MingCute.run_fill,
                                color: primaryColorDeep,
                                size: 25,
                              ),
                              SizedBox(height: 3),
                              headingTextMedium(
                                context,
                                '4.5km',
                                FontWeight.w600,
                                12,
                                blackColor,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8),
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: primaryColorDeep,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                MingCute.bus_line,
                                color: whiteColor,
                                size: 25,
                              ),
                              SizedBox(height: 3),
                              headingTextMedium(
                                context,
                                'Trotro',
                                FontWeight.w600,
                                12,
                                whiteColor,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8),
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: whiteColor,
                            border: Border.all(
                              color: primaryColorDeep,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                MingCute.car_line,
                                color: primaryColorDeep,
                                size: 25,
                              ),
                              SizedBox(height: 3),
                              headingTextMedium(
                                context,
                                'Taxi',
                                FontWeight.w600,
                                12,
                                blackColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: FlutterMap(
              options: MapOptions(
                keepAlive: true,
                initialRotation: -0.0,
                initialCenter: LatLng(
                  widget.desLat ?? 0.0,
                  widget.startLong ?? 0.0,
                ),
                initialZoom: 10.5,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                FutureBuilder<List<LatLng>?>(
                  future: lineService.fetchRouteCoordinates(
                    LatLng(widget.startLat ?? 0.0, widget.startLong ?? 0.0),
                    LatLng(widget.desLat ?? 0.0, widget.desLong ?? 0.0),
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: const CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      return PolylineLayer(
                        polylines: [
                          Polyline(
                            strokeCap: StrokeCap.round,
                            points: snapshot.data!,
                            strokeWidth: 4,
                            color: Colors.blue,
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
                MarkerLayer(
                  alignment: Alignment.center,
                  markers: [
                    Marker(
                      point: LatLng(
                          widget.startLat ?? 0.0, widget.startLong ?? 0.0),
                      child: Builder(
                        builder: (BuildContext context) {
                          return GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.white,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(8.0),
                                        bottom: Radius.circular(8),
                                      ),
                                    ),
                                    content: headingTextMedium(
                                      context,
                                      widget.start ?? '',
                                      FontWeight.w600,
                                      12,
                                    ),
                                  );
                                },
                              );
                            },
                            child: Image.asset(
                              height: 50,
                              width: 50,
                              'assets/pngs/place_marker_48px.png',
                            ),
                          );
                        },
                      ),
                    ),
                    Marker(
                      point: LatLng(
                        widget.desLat ?? 0.0,
                        widget.desLong ?? 0.0,
                      ),
                      child: Builder(
                        builder: (BuildContext context) {
                          return GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.white,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(8.0),
                                        bottom: Radius.circular(8),
                                      ),
                                    ),
                                    content: headingTextMedium(
                                      context,
                                      widget.dest ?? '',
                                      FontWeight.w600,
                                      12,
                                    ),
                                  );
                                },
                              );
                            },
                            child: Image.asset(
                              height: 50,
                              width: 50,
                              'assets/pngs/bus_48px.png',
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                RichAttributionWidget(
                  attributions: [
                    TextSourceAttribution(
                      'OpenStreetMap contributors',
                      // onTap: () => launchUrl(
                      //     Uri.parse('https://openstreetmap.org/copyright')),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
          Positioned(
            left: 20,
            right: 20,
            top: 40,
            child: ShowUpAnimation(
              delay: 400,
              child: Container(
                height: 55,
                width: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: tertiaryColor,
                  boxShadow: const [
                    BoxShadow(
                      spreadRadius: 4,
                      blurRadius: 13,
                      color: Colors.black12,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    headingTextMedium(
                      context,
                      ' Total fare:',
                      FontWeight.w500,
                      20,
                      blackColor,
                    ),
                    SizedBox(width: 15),
                    CediSign(
                      size: 23,
                      color: Colors.red,
                      weight: FontWeight.bold,
                    ),
                    headingTextMedium(
                      context,
                      ' 10.50',
                      FontWeight.bold,
                      23,
                      Colors.red,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
