import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:trotrolive_mobile_new/presentation/stations/repository/model/stations_model.dart';
import '../../../helpers/animation/showup_animation.dart';
import '../../../helpers/text_widgets.dart';
import '../../../helpers/widgets/cedi_widget.dart';
import '../../../helpers/widgets/dialogbox_util.dart';
import '../../../helpers/widgets/shimmer_effect.dart';
import '../../../theme/bloc/theme_bloc.dart';
import '../../../theme/bloc/theme_event.dart';
import '../../../utils/constants/color constants/colors.dart';
import '../../location/bloc/location_bloc.dart';
import '../../stations/bloc/stations_bloc.dart';
import '../../stations/pages/stations_page.dart';
import '../../trips/components/trips_page_arguments.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with AutomaticKeepAliveClientMixin {
  // @override
  // void initState() {
  //   super.initState();
  //   // Fetch location
  //   final locationBloc = context.read<LocationBloc>();
  //   locationBloc.add(LoadLocationEvent());
  //   // Listen for location state and trigger station fetch
  //   locationBloc.stream.listen((state) {
  //     if (state is LocationFetchedState) {
  //       context.read<StationBloc>().add(FetchStationEvent());
  //     }
  //   });
  // }
  @override
  bool get wantKeepAlive => true;
  bool hasFetched = false;
  String? address;
  bool isMessage = false;
  bool showPopup = false;
  String? startPoint;
  String destination = '';

  final destinationController = TextEditingController();
  late final StreamSubscription _locationSubscription;

  // @override
  // void initState() {
  //   super.initState();

  //   final locationBloc = context.read<LocationBloc>();
  //   locationBloc.add(LoadLocationEvent());

  //   _locationSubscription = locationBloc.stream.listen((state) {
  //     if (state is LocationFetchedState) {
  //       context.read<StationBloc>().add(FetchStationEvent());
  //     }
  //   });
  // }

  // @override
  // void dispose() {
  //   _locationSubscription.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<StationBloc, StationState>(listener: (context, state) {
      if (state is StationLoading) {
        Scaffold(
          backgroundColor: secondaryBg,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitDoubleBounce(
                // lineWidth: 3,
                size: 60,
                color: primaryColor,
              ),
              SizedBox(height: 20),
              headingTextMedium(
                  context, 'Waiting for location...', FontWeight.w600, 14),
            ],
          ),
        );
      }
    }, builder: (context, state) {
      //   if (locationState is LocationFailure) {
      //     WidgetsBinding.instance.addPostFrameCallback((_) {
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         SnackBar(
      //           behavior: SnackBarBehavior.floating,
      //           margin: const EdgeInsets.all(8),
      //           content: Text(
      //             'Check your device location or internet connection',
      //             style: const TextStyle(),
      //           ),
      //           backgroundColor: blackColor,
      //         ),
      //       );
      //     });
      //  }
      if (state is StationFailureState) {
        isMessage = true;
        debugPrint("Fetch Failed");
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              elevation: 0.5,
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(8),
              content: Text(
                state.error,
                style: const TextStyle(),
              ),
              backgroundColor: blackColor,
            ),
          );

          // showDialog(
          //   barrierDismissible: false,
          //   context: context,
          //   builder: (BuildContext context) {
          //     return DialogBoxUtil(
          //       context,
          //       onTap: () {
          //         Navigator.pop(context);
          //       },
          //       icon: MingCute.warning_line,
          //       content: state.error,
          //       leftText: '',
          //       rightText: 'Exit',
          //       oncancel: () {
          //         Navigator.pop(context);
          //       },
          //     );
          //   },
          // );
        });
      }
      return Stack(
        children: [
          Scaffold(
            backgroundColor: barBg2,
            extendBody: true,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(190),
              child: Container(
                decoration: BoxDecoration(
                  //color: primaryColor,
                  gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                    colors: [
                      primaryColor.withOpacity(0.93),
                      primaryColorDeep,
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 5,
                      top: -230,
                      right: 40,
                      child: Icon(
                        Icons.circle_outlined,
                        size: 200,
                        color: whiteColor.withOpacity(0.05),
                      ),
                    ),
                    Positioned(
                      bottom: -190,
                      top: 5,
                      right: -90,
                      child: Icon(
                        Icons.emoji_objects_outlined,
                        size: 200,
                        color: whiteColor.withOpacity(0.05),
                      ),
                    ),
                    Positioned(
                      bottom: -190,
                      top: 5,
                      left: -50,
                      child: Icon(
                        Icons.circle_outlined,
                        size: 280,
                        color: whiteColor.withOpacity(0.05),
                      ),
                    ),
                    Positioned(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          AppBar(
                            automaticallyImplyLeading: false,
                            backgroundColor: Colors.transparent,
                            actions: [
                              GestureDetector(
                                onTap: () {
                                  // context
                                  //     .read<ThemeBloc>()
                                  //     .add(ToggleThemeEvent());
                                  // //Navigator.pushNamed(context, '/notification');
                                },
                                child: CircleAvatar(
                                  backgroundColor: blackColorShade,
                                  child: Center(
                                    child: Badge(
                                      child: Icon(
                                        MingCute.notification_line,
                                        size: 21,
                                        color: whiteColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 15),
                            ],
                            title: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: blackColorShade,
                                  child: Center(
                                    child: Icon(
                                      MingCute.location_line,
                                      color: whiteColor,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    subheadingText(
                                      context,
                                      'Location',
                                      align: TextAlign.start,
                                      size: 12,
                                      maxlines: 2,
                                      color: secondaryColor,
                                    ),
                                    BlocBuilder<LocationBloc, LocationState>(
                                      builder: (context, state) {
                                        if (state is LocationFetchedState) {
                                          return appbarText(context,
                                              state.address!, whiteColor, 12);
                                        } else if (state is LocationLoading) {
                                          return appbarText(
                                            context,
                                            'Location loading.....',
                                            whiteColor,
                                            12,
                                          );
                                        }
                                        return appbarText(
                                          context,
                                          'Getting your location....',
                                          whiteColor,
                                          12,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            height: 120,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  headingTextMedium(
                                      context,
                                      "Where are you going this weekend?",
                                      FontWeight.w500,
                                      18,
                                      whiteColor),
                                  SizedBox(height: 15),
                                  TextFormField(
                                    //controller: searchController,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          fontSize: 15,
                                          color: blackColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                    //onChanged: (value) => (),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Type something';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Search station here....",
                                      hintStyle: TextStyle(
                                          color: iconGrey.withOpacity(0.7),
                                          fontSize: 13),
                                      prefixIcon: const Icon(
                                        MingCute.search_2_line,
                                        color: secondaryColor,
                                        size: 23,
                                      ),
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            showPopup = true;
                                          });
                                        },
                                        child: Container(
                                          width: 65,
                                          decoration: BoxDecoration(
                                            color: secondaryColor,
                                            borderRadius:
                                                BorderRadius.circular(60),
                                          ),
                                          child: Icon(
                                            MingCute.list_search_fill,
                                            color: blackColor,
                                            size: 19,
                                          ),
                                        ),
                                      ),
                                      filled: true,
                                      isDense: true,
                                      fillColor: whiteColor,
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        borderSide: BorderSide.none,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        headingTextMedium(
                          context,
                          'Trotro Stories',
                          FontWeight.w600,
                          14,
                        ),
                        labelseeAllText(context, 'See All'),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/events');
                      },
                      child: Container(
                        height: 155,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          border: Border.all(
                              width: 2.5, color: primaryContainerShade),
                          borderRadius: BorderRadius.circular(17),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 150,
                              width: 175,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    headingTextMedium(
                                        context,
                                        'Kaneshie Station Moments',
                                        FontWeight.w600,
                                        14),
                                    SizedBox(height: 8),
                                    subheadingTextMedium(
                                      context,
                                      'Vendors shouting, passengers rushing...',
                                      12,
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      height: 30,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: Center(
                                        child: labelTextRegular(
                                          context,
                                          'View more',
                                          whiteColor,
                                          11.5,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 150,
                              width: 145,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: Image.asset(
                                          "assets/images/feedbackImage.png")
                                      .image,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        headingTextMedium(
                          context,
                          'Nearby Stations',
                          FontWeight.w600,
                          14,
                        ),
                        labelseeAllText(context, 'See all stations'),
                      ],
                    ),
                    BlocBuilder<StationBloc, StationState>(
                      builder: (context, state) {
                        if (state is StationLoading) {
                          return StationShimmerTile();
                        }
                        if (state is StationFailureState) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                              child: Text(state.error,
                                  style: TextStyle(color: Colors.red)),
                            ),
                          );
                        }

                        if (state is StationFetchedState &&
                            state.stations!.isNotEmpty) {
                          return SizedBox(
                            height: 350,
                            child: ListView.builder(
                              itemCount: state.stations!.length,
                              itemBuilder: (context, index) {
                                final station = state.stations![index];
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      startPoint = station.name;
                                      showPopup = !showPopup;
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: whiteColor,
                                      border: Border.all(
                                          color: primaryContainerShade,
                                          width: 2.5),
                                      borderRadius: BorderRadius.circular(17),
                                    ),
                                    child: Column(
                                      children: [
                                        // Top Section
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Icon + Labels
                                            Column(
                                              children: [
                                                _dotIcon(Colors.blue,
                                                    Icons.location_on_outlined),
                                                ...List.generate(
                                                  5,
                                                  (_) => const Icon(
                                                      Icons.circle,
                                                      size: 6,
                                                      color: outlineGrey),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 10),
                                            // Station Info
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  headingTextMedium(
                                                      context,
                                                      station.name,
                                                      FontWeight.w600,
                                                      14),
                                                  subheadingText(context,
                                                      "${station.distanceToUser} km",
                                                      size: 10),
                                                  const SizedBox(height: 5),
                                                  Row(
                                                    children: [
                                                      subheadingText(context,
                                                          'Station Type: ',
                                                          size: 11),
                                                      subheadingText(
                                                        context,
                                                        station.isBusStop
                                                            ? ' Bus Stop'
                                                            : ' Not Bus Stop',
                                                        size: 11,
                                                        color: Colors.green,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            // GPRTU Info
                                            SizedBox(
                                              width: 100,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(height: 8),
                                                  subheadingText(
                                                      context, 'TAKE NOTE!!',
                                                      size: 11),
                                                  const SizedBox(height: 2),
                                                  subheadingText(
                                                    context,
                                                    'ALL FARES ARE ENDORSED BY THE GPRTU.',
                                                    align: TextAlign.start,
                                                    size: 10,
                                                    maxlines: 3,
                                                    color: Colors.blue,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Divider(
                                            color: primaryContainerShade),
                                        // Bottom Action Row
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            _iconLabel(
                                                context,
                                                MingCute.heart_line,
                                                'Favorite'),
                                            _iconLabel(
                                                context,
                                                Icons.ios_share_outlined,
                                                'Share'),
                                            _iconLabel(
                                                context,
                                                MingCute.eye_2_line,
                                                '1.2k visits'),
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
                        return ShowUpAnimation(
                          delay: 200,
                          child: PlaceholderContainer(),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
          if (showPopup)
            Stack(
              children: [
                Positioned.fill(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        showPopup = false;
                      });
                    },
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Material(
                    elevation: 8,
                    borderRadius: BorderRadius.circular(17),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(17),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(),
                            horizontalTitleGap: 5,
                            minLeadingWidth: 3,
                            minVerticalPadding: 2,
                            dense: true,
                            leading: CircleAvatar(
                              backgroundColor: Colors.red[50],
                              radius: 20,
                              child: const Icon(Icons.ads_click_rounded),
                            ),
                            title: Text(
                              startPoint ?? 'No station selected',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  "Trotro Bus",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                        color: Colors.black45,
                                        fontSize: 12,
                                      ),
                                ),
                              ],
                            ),
                            trailing: Container(
                              height: 30,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: const Color.fromARGB(255, 69, 212, 74),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "Bust Stop",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                        color: Colors.green,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        height: 3,
                                      ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Destination",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                      color: Colors.black,
                                      fontSize: 13,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          // Container(
                          //   height: 50,
                          //   width: MediaQuery.of(context).size.width,
                          //   decoration: BoxDecoration(
                          //     color: Colors.grey.shade200.withOpacity(0.4),
                          //     border: Border.all(
                          //       width: 1,
                          //       color: Colors.grey.shade400.withOpacity(0.5),
                          //     ),
                          //     borderRadius: BorderRadius.circular(13),
                          //   ),
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(8.0),
                          //     child: Row(
                          //       mainAxisAlignment:
                          //           MainAxisAlignment.spaceBetween,
                          //       children: [
                          //         Padding(
                          //           padding: const EdgeInsets.all(8.0),
                          //           child: Row(
                          //             children: [
                          //               Text(
                          //                 "Enter Destination",
                          //                 style: Theme.of(context)
                          //                     .textTheme
                          //                     .bodySmall!
                          //                     .copyWith(
                          //                       fontSize: 13,
                          //                       color: Colors.black54,
                          //                     ),
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //         Container(
                          //           height: 20,
                          //           width: 20,
                          //           decoration: BoxDecoration(
                          //             color: primaryColor,
                          //             borderRadius: BorderRadius.circular(20),
                          //           ),
                          //           child: const Center(
                          //             child: Icon(
                          //               Icons.location_on,
                          //               size: 13,
                          //               weight: 8,
                          //               grade: 8,
                          //               opticalSize: 8,
                          //               color: Colors.white,
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          TextFormField(
                            controller: destinationController,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: 15,
                                      color: blackColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                            //onChanged: (value) => (),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Destination';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              destination = value!.trim();
                            },
                            decoration: InputDecoration(
                              hintText: "Enter Destination",
                              hintStyle: TextStyle(
                                  color: iconGrey.withOpacity(0.7),
                                  fontSize: 13),
                              prefixIcon: const Icon(
                                MingCute.location_2_fill,
                                color: primaryColorDeep,
                                size: 23,
                              ),
                              filled: true,
                              isDense: true,
                              fillColor: whiteColor,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(color: Colors.green),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: outlineGrey),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/trips',
                                arguments: TripsPageArguments(
                                  startLocation: 'Circle',
                                  destination: destinationController.text,
                                ),
                              );
                              setState(() {
                                showPopup = !showPopup;
                              });
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                child: Text(
                                  "Check your fare",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      );
    });
  }

  Widget PlaceholderContainer() {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Text(
          'No Stations Available',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _dotIcon(Color color, IconData icon) {
    return Container(
      height: 22,
      width: 22,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Center(child: Icon(icon, size: 15, color: whiteColor)),
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
