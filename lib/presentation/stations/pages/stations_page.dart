import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:trotrolive_mobile_new/presentation/stations/bloc/stations_bloc.dart';
import 'package:trotrolive_mobile_new/presentation/location/bloc/location_bloc.dart';
import '../../../helpers/text_widgets.dart';
import '../../../helpers/widgets/cedi_widget.dart';
import '../../../helpers/widgets/dialogbox_util.dart';
import '../../../utils/constants/color constants/colors.dart';

class StationsPage extends StatefulWidget {
  const StationsPage({super.key});

  @override
  State<StationsPage> createState() => _StationsPageState();
}

class _StationsPageState extends State<StationsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  bool hasFetched = false;
  String? address;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final locationState = context.watch<LocationBloc>().state;
    return BlocConsumer<StationBloc, StationState>(
      listener: (context, state) {
        if (state is StationFailureState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return DialogBoxUtil(
                  context,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  icon: MingCute.warning_line,
                  content: state.error,
                  leftText: '',
                  rightText: 'Exit',
                  oncancel: () {
                    Navigator.pop(context);
                  },
                );
              },
            );
          });
        }
      },
      builder: (context, state) {
        if (locationState is LocationFailure) {
          return Container(
            color: secondaryBg,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_off_rounded,
                    color: Colors.black26,
                    size: 80,
                  ),
                  SizedBox(height: 18),
                  headingTextMedium(
                      context,
                      "Turn on your device's location service or wait for app to fetch device location to access nearby shops.",
                      FontWeight.w600,
                      14),
                  SizedBox(height: 8),
                ],
              ),
            ),
          );
        }
        if (locationState is LocationFetchedState && !hasFetched) {
          address = locationState.address2;
          if (state is! StationFetchedState && state is! StationLoading) {
            context.read<StationBloc>().add(FetchStationEvent());
            hasFetched = true;
          }
        }
        if (state is StationFailureState) {
          return Scaffold(
            backgroundColor: secondaryBg,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  headingTextMedium(context, state.error, FontWeight.w600, 14),
                ],
              ),
            ),
          );
        }
        if (state is StationFetchedState) {
          final stations = state.stations;
          if (stations == null || stations.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/bg19.png",
                    height: 45,
                    width: 45,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "No nearby stations found !!",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            );
          }
          stations.sort((a, b) => a.distanceToUser.compareTo(b.distanceToUser));
          return SizedBox(
            height: 350,
            child: ListView.builder(
              itemCount: stations.length,
              itemBuilder: (context, index) {
                final station = stations[index];
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 160,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      border: Border.all(
                        color: primaryContainerShade,
                        width: 2.5,
                      ),
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 110,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 210,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          _dotIcon(Colors.blue,
                                              Icons.arrow_drop_up_sharp),
                                          ...List.generate(
                                            5,
                                            (_) => const Icon(Icons.circle,
                                                size: 6, color: outlineGrey),
                                          ),
                                          _dotIcon(Colors.red,
                                              Icons.arrow_drop_down_sharp),
                                        ],
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          headingTextMedium(
                                            context,
                                            station.name,
                                            FontWeight.w600,
                                            14,
                                          ),
                                          subheadingText(
                                            context,
                                            "${station.distanceToUser.round()}km",
                                            size: 10,
                                          ),
                                          const SizedBox(height: 23),
                                          headingTextMedium(
                                            context,
                                            'Kejetia Market',
                                            FontWeight.w600,
                                            14,
                                          ),
                                          Row(
                                            children: [
                                              subheadingText(
                                                  context, 'Transport Type: ',
                                                  size: 10),
                                              subheadingText(
                                                context,
                                                'Trotro',
                                                size: 10,
                                                color: Colors.green,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const VerticalDivider(
                                  width: 1, color: outlineGrey),
                              const SizedBox(width: 8),
                              SizedBox(
                                width: 100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 5),
                                    subheadingText(context, 'TRIP AMOUNT',
                                        size: 11),
                                    const SizedBox(height: 3),
                                    Row(
                                      children: [
                                        const CediSign(
                                            size: 21, weight: FontWeight.bold),
                                        const SizedBox(width: 1),
                                        headingTextMedium(context, '9.50p',
                                            FontWeight.w600, 21),
                                      ],
                                    ),
                                    subheadingText(context, 'TAKE NOTE!!',
                                        size: 11),
                                    const SizedBox(height: 2),
                                    subheadingText(
                                      context,
                                      'ALL FARES ARE ENDORSED BY THE GPRTU.',
                                      size: 10,
                                      maxlines: 3,
                                      color: Colors.blue,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(color: primaryContainerShade),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _iconLabel(
                                context, MingCute.heart_line, 'Favorite'),
                            _iconLabel(
                                context, Icons.ios_share_outlined, 'Share'),
                            _iconLabel(
                                context, MingCute.eye_2_line, '1.2k visits'),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
        return Scaffold(
          backgroundColor: secondaryBg,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitDoubleBounce(
                size: 60,
                color: primaryColor,
              ),
              SizedBox(height: 20),
              headingTextMedium(
                  context, 'Waiting for location...', FontWeight.w600, 14),
            ],
          ),
        );
      },
    );
  }

  Widget _dotIcon(Color color, IconData icon) {
    return Container(
      height: 18,
      width: 18,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Center(child: Icon(icon, size: 18, color: whiteColor)),
    );
  }

  Widget _iconLabel(BuildContext context, IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, color: outlineGrey, size: 17),
        const SizedBox(width: 3),
        subheadingText(context, label, size: 11),
      ],
    );
  }
}
