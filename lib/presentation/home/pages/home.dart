import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:trotrolive_mobile_new/presentation/stations/repository/model/stations_model.dart';
import '../../../helpers/text_widgets.dart';
import '../../../helpers/widgets/cedi_widget.dart';
import '../../../helpers/widgets/dialogbox_util.dart';
import '../../../utils/constants/color constants/colors.dart';
import '../../location/bloc/location_bloc.dart';
import '../../stations/bloc/stations_bloc.dart';
import '../../stations/pages/stations_page.dart';

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

  late final StreamSubscription _locationSubscription;

  @override
  void initState() {
    super.initState();

    final locationBloc = context.read<LocationBloc>();
    locationBloc.add(LoadLocationEvent());

    _locationSubscription = locationBloc.stream.listen((state) {
      if (state is LocationFetchedState) {
        context.read<StationBloc>().add(FetchStationEvent());
      }
    });
  }

  @override
  void dispose() {
    _locationSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final locationState = context.watch<LocationBloc>().state;
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
      if (locationState is LocationFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(8),
            content: Text(
              'Check your device location or internet connection',
              style: const TextStyle(),
            ),
            backgroundColor: blackColor,
          ),
        );

        // Container(
        //   color: secondaryBg,
        //   child: Padding(
        //     padding: const EdgeInsets.all(50.0),
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Icon(
        //           Icons.location_off_rounded,
        //           color: Colors.black26,
        //           size: 80,
        //         ),
        //         SizedBox(height: 18),
        //         headingTextMedium2(
        //             context,
        //             "Turn on your device's location service or wait for app to fetch device location",
        //             FontWeight.w500,
        //             13),
        //         SizedBox(height: 8),
        //       ],
        //     ),
        //   ),
        // );
      }

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
                                  Navigator.pushNamed(context, '/notification');
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
                                          // scrollBottomSheet(context);
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
                    Container(
                      height: 145,
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
                            height: 140,
                            width: 175,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  headingTextMedium(context, 'Free offers',
                                      FontWeight.w600, 14),
                                  SizedBox(height: 8),
                                  subheadingTextMedium(
                                    context,
                                    'Enjoy exclusive discount on all routes today.',
                                    12,
                                  ),
                                  SizedBox(height: 15),
                                  Container(
                                    height: 35,
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
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        headingTextMedium(
                          context,
                          'Nearby Stations! ',
                          FontWeight.w600,
                          14,
                        ),
                        labelseeAllText(context, 'See All'),
                      ],
                    ),
                    // ShowUpAnimation(
                    //   delay: 200,
                    //   child: Container(
                    //     height: 160,
                    //     width: MediaQuery.of(context).size.width,
                    //     padding: EdgeInsets.all(5),
                    //     decoration: BoxDecoration(
                    //       color: whiteColor,
                    //       border:
                    //           Border.all(width: 2.5, color: primaryContainerShade),
                    //       borderRadius: BorderRadius.circular(17),
                    //     ),
                    //     child: Column(
                    //       mainAxisAlignment: MainAxisAlignment.start,
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         SizedBox(
                    //           height: 110,
                    //           child: Row(
                    //             mainAxisAlignment: MainAxisAlignment.start,
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               SizedBox(
                    //                 height: 150,
                    //                 width: 210,
                    //                 child: Padding(
                    //                   padding: const EdgeInsets.all(10.0),
                    //                   child: Row(
                    //                     crossAxisAlignment: CrossAxisAlignment.start,
                    //                     children: [
                    //                       SizedBox(
                    //                         height: 90,
                    //                         width: 40,
                    //                         child: Column(
                    //                           children: [
                    //                             Container(
                    //                               height: 18,
                    //                               width: 18,
                    //                               decoration: BoxDecoration(
                    //                                 color: Colors.blue,
                    //                                 borderRadius:
                    //                                     BorderRadius.circular(25),
                    //                               ),
                    //                               child: Center(
                    //                                 child: Icon(
                    //                                   Icons.arrow_drop_up_sharp,
                    //                                   color: whiteColor,
                    //                                   size: 18,
                    //                                 ),
                    //                               ),
                    //                             ),
                    //                             SizedBox(height: 3),
                    //                             Icon(
                    //                               Icons.circle,
                    //                               color: outlineGrey,
                    //                               size: 6,
                    //                             ),
                    //                             SizedBox(height: 3),
                    //                             Icon(
                    //                               Icons.circle,
                    //                               color: outlineGrey,
                    //                               size: 6,
                    //                             ),
                    //                             SizedBox(height: 3),
                    //                             Icon(
                    //                               Icons.circle,
                    //                               color: outlineGrey,
                    //                               size: 6,
                    //                             ),
                    //                             SizedBox(height: 3),
                    //                             Icon(
                    //                               Icons.circle,
                    //                               color: outlineGrey,
                    //                               size: 6,
                    //                             ),
                    //                             SizedBox(height: 3),
                    //                             Icon(
                    //                               Icons.circle,
                    //                               color: outlineGrey,
                    //                               size: 6,
                    //                             ),
                    //                             SizedBox(height: 3),
                    //                             Container(
                    //                               height: 18,
                    //                               width: 18,
                    //                               decoration: BoxDecoration(
                    //                                 color: Colors.red,
                    //                                 borderRadius:
                    //                                     BorderRadius.circular(25),
                    //                               ),
                    //                               child: Center(
                    //                                 child: Icon(
                    //                                   Icons.arrow_drop_down_sharp,
                    //                                   color: whiteColor,
                    //                                   size: 18,
                    //                                 ),
                    //                               ),
                    //                             ),
                    //                           ],
                    //                         ),
                    //                       ),
                    //                       Column(
                    //                         crossAxisAlignment:
                    //                             CrossAxisAlignment.start,
                    //                         children: [
                    //                           headingTextMedium(
                    //                             context,
                    //                             'Dansoman',
                    //                             FontWeight.w600,
                    //                             14,
                    //                           ),
                    //                           subheadingText(
                    //                             context,
                    //                             'June 23, 14:00',
                    //                             align: TextAlign.start,
                    //                             size: 10,
                    //                           ),
                    //                           SizedBox(height: 23),
                    //                           headingTextMedium(
                    //                             context,
                    //                             'Kasoa',
                    //                             FontWeight.w600,
                    //                             14,
                    //                           ),
                    //                           Row(
                    //                             children: [
                    //                               subheadingText(
                    //                                 context,
                    //                                 'Transport Type: ',
                    //                                 align: TextAlign.start,
                    //                                 size: 10,
                    //                               ),
                    //                               subheadingText(
                    //                                 context,
                    //                                 'Trotro',
                    //                                 align: TextAlign.start,
                    //                                 size: 10,
                    //                                 maxlines: 2,
                    //                                 color: Colors.green,
                    //                               ),
                    //                             ],
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ),
                    //               Container(
                    //                 height: 110,
                    //                 width: 1,
                    //                 color: outlineGrey,
                    //               ),
                    //               SizedBox(width: 8),
                    //               Container(
                    //                 height: 120,
                    //                 width: 100,
                    //                 decoration: BoxDecoration(),
                    //                 child: Column(
                    //                   mainAxisAlignment: MainAxisAlignment.start,
                    //                   crossAxisAlignment: CrossAxisAlignment.start,
                    //                   children: [
                    //                     SizedBox(height: 5),
                    //                     subheadingText(
                    //                       context,
                    //                       'TRIP AMOUNT',
                    //                       align: TextAlign.start,
                    //                       size: 11,
                    //                     ),
                    //                     Row(
                    //                       children: [
                    //                         CediSign(
                    //                           size: 21,
                    //                           weight: FontWeight.bold,
                    //                         ),
                    //                         SizedBox(width: 1),
                    //                         headingTextMedium(
                    //                           context,
                    //                           '5.00p',
                    //                           FontWeight.w600,
                    //                           21,
                    //                         ),
                    //                       ],
                    //                     ),
                    //                     SizedBox(height: 1),
                    //                     subheadingText(
                    //                       context,
                    //                       'TAKE NOTE!!',
                    //                       align: TextAlign.start,
                    //                       size: 11,
                    //                     ),
                    //                     SizedBox(height: 2),
                    //                     subheadingText(
                    //                       context,
                    //                       'ALL FARES ARE ENDORSED BY THE GPRTU.',
                    //                       align: TextAlign.start,
                    //                       size: 10,
                    //                       maxlines: 3,
                    //                       color: Colors.blue,
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //         Divider(
                    //           color: primaryContainerShade,
                    //         ),
                    //         Row(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: [
                    //             Row(
                    //               children: [
                    //                 Icon(
                    //                   MingCute.heart_line,
                    //                   color: outlineGrey,
                    //                   size: 17,
                    //                 ),
                    //                 subheadingText(
                    //                   context,
                    //                   'Favorite',
                    //                   align: TextAlign.start,
                    //                   size: 11,
                    //                 ),
                    //               ],
                    //             ),
                    //             SizedBox(width: 50),
                    //             Row(
                    //               mainAxisAlignment: MainAxisAlignment.center,
                    //               children: [
                    //                 Icon(
                    //                   Icons.ios_share_outlined,
                    //                   color: outlineGrey,
                    //                   size: 17,
                    //                 ),
                    //                 subheadingText(
                    //                   context,
                    //                   'Share',
                    //                   align: TextAlign.start,
                    //                   size: 11,
                    //                 ),
                    //               ],
                    //             ),
                    //             SizedBox(width: 50),
                    //             Row(
                    //               children: [
                    //                 Icon(
                    //                   MingCute.eye_2_line,
                    //                   color: outlineGrey,
                    //                   size: 17,
                    //                 ),
                    //                 subheadingText(
                    //                   context,
                    //                   '1.2k visits',
                    //                   align: TextAlign.start,
                    //                   size: 11,
                    //                 ),
                    //               ],
                    //             ),
                    //           ],
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: 10),

                    BlocBuilder<StationBloc, StationState>(
                        builder: (context, state) {
                      if (state is StationFetchedState) {
                        //final station = state.stations;
                        return SizedBox(
                          height: 350,
                          child: ListView.builder(
                            itemCount: state.stations!.length,
                            itemBuilder: (context, index) {
                              // final stations = station![index];
                              debugPrint(
                                  "Stations rendered: ${state.stations}");
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    startPoint = state.stations![index].name;
                                    showPopup = !showPopup;
                                  });
                                  // _displayBottomSheet(context,
                                  //     stationname: state.stations![index]);
                                },
                                child: Container(
                                  height: 130,
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
                                        height: 75,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 210,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Row(
                                                  children: [
                                                    Column(
                                                      children: [
                                                        _dotIcon(
                                                            Colors.blue,
                                                            Icons
                                                                .location_on_outlined),
                                                        ...List.generate(
                                                          5,
                                                          (_) => const Icon(
                                                              Icons.circle,
                                                              size: 6,
                                                              color:
                                                                  outlineGrey),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        headingTextMedium(
                                                          context,
                                                          state.stations![index]
                                                              .name,
                                                          FontWeight.w600,
                                                          14,
                                                        ),
                                                        subheadingText(
                                                          context,
                                                          "${state.stations![index].distanceToUser}km",
                                                          size: 10,
                                                        ),
                                                        const SizedBox(
                                                            height: 5),
                                                        Row(
                                                          children: [
                                                            subheadingText(
                                                                context,
                                                                'Station Type: ',
                                                                size: 11),
                                                            subheadingText(
                                                              context,
                                                              state.stations![index]
                                                                          .isBusStop ==
                                                                      true
                                                                  ? ' Bus Stop'
                                                                  : ' Not Bus Stop',
                                                              size: 11,
                                                              color:
                                                                  Colors.green,
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
                                                width: 0.5, color: outlineGrey),
                                            const SizedBox(width: 8),
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
                                      ),
                                      Divider(color: primaryContainerShade),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          _iconLabel(context,
                                              MingCute.heart_line, 'Favorite'),
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
                      return Center(
                        child: SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator()),
                      );
                    }),
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
                              startPoint.toString(),
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
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200.withOpacity(0.4),
                              border: Border.all(
                                width: 1,
                                color: Colors.grey.shade400.withOpacity(0.5),
                              ),
                              borderRadius: BorderRadius.circular(13),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Enter Destination",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                fontSize: 13,
                                                color: Colors.black54,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.location_on,
                                        size: 13,
                                        weight: 8,
                                        grade: 8,
                                        opticalSize: 8,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
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

  Future _displayBottomSheet(BuildContext context,
      {required StationModel stationname}) {
    TextEditingController textFieldValue1 = TextEditingController();
    textFieldValue1.text = stationname.name;
    TextEditingController textFieldValue2 = TextEditingController();

    String startingPoint = '';
    String destination = '';

    String errorMessage = 'Please enter destination !!';
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(5.0),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) => SingleChildScrollView(
        child: SizedBox(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 120,
                          width: 50,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/route_50px.png"),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 145,
                          width: 290,
                          child: Column(
                            children: [
                              TextFormField(
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                autofocus: true,
                                controller: textFieldValue1,
                                readOnly: textFieldValue1.text.isNotEmpty,
                                decoration: InputDecoration(
                                  isDense: true,
                                  hintStyle: const TextStyle(
                                    color: primaryColor,
                                  ),
                                  prefixIcon: const Icon(Icons.location_pin,
                                      color: Colors.black45),
                                  labelStyle: const TextStyle(
                                    fontSize: 15,
                                    color: primaryColor,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor:
                                      const Color.fromARGB(255, 225, 225, 225),
                                ),
                              ),
                              const SizedBox(height: 7),
                              TextFormField(
                                scrollPhysics: const BouncingScrollPhysics(),
                                enableSuggestions: true,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                controller: textFieldValue2,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return errorMessage;
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  destination = value!.trim();
                                },
                                decoration: InputDecoration(
                                  isDense: true,
                                  hintText: 'Enter Destination',
                                  hintStyle: const TextStyle(),
                                  prefixIcon: const Icon(
                                    Icons.near_me,
                                    color: Colors.black45,
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      textFieldValue2.clear();
                                    },
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.black45,
                                    ),
                                  ),
                                  labelStyle: const TextStyle(
                                      fontSize: 15, color: primaryColor),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor:
                                      const Color.fromARGB(255, 225, 225, 225),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: GestureDetector(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          // Get.to(() => SearchPage(
                          //     textFieldValue1: textFieldValue1,
                          //     textFieldValue2: textFieldValue2));
                        }
                      },
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: primaryColor,
                        ),
                        child: const Center(
                          child: Text(
                            'Know Your Fare',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
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
      ),
    );
  }
}
