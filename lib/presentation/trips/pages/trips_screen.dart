// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trotrolive_mobile_new/helpers/animation/showup_animation.dart';
import 'package:trotrolive_mobile_new/presentation/trips/repository/model/trips_model.dart';

import '../../../helpers/text_widgets.dart';
import '../../../helpers/widgets/dialogbox_util.dart';
import '../../../utils/constants/color constants/colors.dart';
import '../bloc/trips_bloc.dart';

class TripsPage extends StatefulWidget {
  final String? startLocation;
  final String? destination;
  const TripsPage({
    super.key,
    this.startLocation,
    this.destination,
  });

  @override
  State<TripsPage> createState() => _TripsPageState();
}

class _TripsPageState extends State<TripsPage>
    with SingleTickerProviderStateMixin {
  List<TripsModel>? trips;
  late ScrollController _scrollController;
  bool _showMoreInfoButton = false;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    context.read<TripsBloc>().add(FetchTripEvent(
          startingPoint: widget.startLocation,
          destination: widget.destination,
        ));
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _fadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_fadeController);
  }

  void _onScroll() {
    final bloc = context.read<TripsBloc>();
    final state = bloc.state;

    // Detect if user has scrolled to bottom and there's more to load
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100 &&
        state is TripsFetchedState &&
        state.nextUrl != null &&
        !_showMoreInfoButton) {
      setState(() {
        _showMoreInfoButton = true;
      });
      _fadeController.forward();
    } else if (_scrollController.position.pixels <
            _scrollController.position.maxScrollExtent - 100 &&
        _showMoreInfoButton) {
      setState(() {
        _showMoreInfoButton = false;
      });
      _fadeController.reverse();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TripsBloc, TripsState>(
      listener: (BuildContext context, state) {
        if (state is TripsFailureState) {
          debugPrint("Fetch Failed ${state.error}");
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
          });
        }
      },
      builder: (BuildContext context, state) {
        if (state is TripsFetchedState) {
          final trips = state.trips!;
          final hasMore = state.hasMore;
          return Scaffold(
            backgroundColor: primaryColorDeep,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(120),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                    colors: [
                      primaryColor.withOpacity(0.95),
                      primaryColorDeep,
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 5,
                      top: -180,
                      right: -50,
                      child: Icon(
                        Icons.phone_android_rounded,
                        size: 200,
                        color: Color.fromRGBO(255, 255, 255, 0.05),
                      ),
                    ),
                    Positioned(
                      bottom: -190,
                      top: 5,
                      left: -50,
                      child: Icon(
                        Icons.luggage_rounded,
                        size: 280,
                        color: whiteColor.withOpacity(0.05),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      top: 20,
                      right: 20,
                      left: 20,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            headingTextMedium(
                              context,
                              "Available Trips",
                              FontWeight.bold,
                              20,
                              whiteColor,
                            ),
                            SizedBox(height: 2),
                            subheadingText(
                              context,
                              'Fares for certain routes may change periodically due to changes from our database.!!',
                              size: 12,
                              color: secondaryColor4,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            extendBody: true,
            body: SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                  ),
                  color: whiteColor,
                ),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),
                      SizedBox(
                        height: 40,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 40,
                                width: 130,
                                decoration: BoxDecoration(
                                  // color: secondaryColor3.withOpacity(0.4),
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    headingTextMedium(
                                      context,
                                      '${trips.length} trips found!',
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
                      SizedBox(height: 5),
                      RefreshIndicator(
                        onRefresh: () async {
                          context.read<TripsBloc>()..add(FetchTripEvent());
                        },
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: ListView.builder(
                            controller: _scrollController,
                            scrollDirection: Axis.vertical,
                            itemCount: trips.length + (hasMore ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index == trips.length) {
                                return state.nextUrl != null &&
                                        _showMoreInfoButton
                                    ? FadeTransition(
                                        opacity: _fadeAnimation,
                                        child: Center(
                                          child: GestureDetector(
                                            onTap: () {
                                              context.read<TripsBloc>().add(
                                                    LoadMoreTripsEvent(
                                                      nextUrl: state.nextUrl!,
                                                      currentTrips:
                                                          state.trips ?? [],
                                                    ),
                                                  );
                                            },
                                            child: Container(
                                              height: 30,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(35),
                                                // border: Border.all(
                                                //     color: primaryColorDeep),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Load more',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                        color: primaryColorDeep,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox.shrink();
                              }
                              final trip = trips[index];
                              return Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 160,
                                      width: MediaQuery.of(context).size.width,
                                      // padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.bottomLeft,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            primaryColor.withOpacity(0.95),
                                            primaryColorDeep,
                                          ],
                                        ),
                                        border: Border.all(
                                          color: primaryContainerShade,
                                          width: 2.5,
                                        ),
                                        borderRadius: BorderRadius.circular(17),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 115,
                                            child: Container(
                                              height: 150,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(14),
                                                  topRight: Radius.circular(14),
                                                ),
                                                color: whiteColor,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5.0,
                                                        vertical: 15),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 95,
                                                      width: 40,
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            height: 22,
                                                            width: 22,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.blue,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25),
                                                            ),
                                                            child: Center(
                                                              child: Icon(
                                                                MingCute
                                                                    .location_fill,
                                                                color:
                                                                    whiteColor,
                                                                size: 15,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(height: 3),
                                                          Icon(
                                                            Icons.circle,
                                                            color: outlineGrey,
                                                            size: 6,
                                                          ),
                                                          SizedBox(height: 3),
                                                          Icon(
                                                            Icons.circle,
                                                            color: outlineGrey,
                                                            size: 6,
                                                          ),
                                                          SizedBox(height: 3),
                                                          Icon(
                                                            Icons.circle,
                                                            color: outlineGrey,
                                                            size: 6,
                                                          ),
                                                          SizedBox(height: 3),
                                                          Container(
                                                            height: 22,
                                                            width: 22,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.red,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25),
                                                            ),
                                                            child: Center(
                                                              child: Icon(
                                                                Icons
                                                                    .location_searching_rounded,
                                                                color:
                                                                    whiteColor,
                                                                size: 15,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        headingTextMedium(
                                                          context,
                                                          trip.startStation.name
                                                                  .toString() ??
                                                              '',
                                                          FontWeight.w600,
                                                          14,
                                                        ),
                                                        subheadingText(
                                                          context,
                                                          trip.startStation
                                                                      .isBusStop ==
                                                                  true
                                                              ? 'Bus Stop'
                                                              : 'Not Bus Stop',
                                                          align:
                                                              TextAlign.start,
                                                          size: 10,
                                                        ),
                                                        SizedBox(height: 20),
                                                        headingTextMedium(
                                                          context,
                                                          trip.destination.name
                                                                  .toString() ??
                                                              '',
                                                          FontWeight.w600,
                                                          14,
                                                        ),
                                                        Row(
                                                          children: [
                                                            subheadingText(
                                                              context,
                                                              trip.destination
                                                                          .isBusStop ==
                                                                      true
                                                                  ? 'Bus Stop'
                                                                  : 'Not Bus Stop',
                                                              align: TextAlign
                                                                  .start,
                                                              size: 10,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            // Container(
                                            //   height: 110,
                                            //   width: 1,
                                            //   color: outlineGrey,
                                            // ),
                                            // SizedBox(width: 8),
                                            // Container(
                                            //   height: 120,
                                            //   width: 100,
                                            //   decoration: BoxDecoration(),
                                            //   child: Column(
                                            //     mainAxisAlignment:
                                            //         MainAxisAlignment.start,
                                            //     crossAxisAlignment:
                                            //         CrossAxisAlignment.start,
                                            //     children: [
                                            //       SizedBox(height: 5),
                                            //       subheadingText(
                                            //         context,
                                            //         'TRIP AMOUNT',
                                            //         TextAlign.start,
                                            //         11,
                                            //       ),
                                            //       SizedBox(height: 3),
                                            //       Row(
                                            //         children: [
                                            //           CediSign(
                                            //             size: 21,
                                            //             weight: FontWeight.bold,
                                            //           ),
                                            //           SizedBox(width: 1),
                                            //           headingTextMedium(
                                            //             context,
                                            //             '9.50p',
                                            //             FontWeight.w600,
                                            //             21,
                                            //           ),
                                            //         ],
                                            //       ),
                                            //       SizedBox(height: 1),
                                            //       subheadingText(
                                            //         context,
                                            //         'TAKE NOTE!!',
                                            //         TextAlign.start,
                                            //         11,
                                            //       ),
                                            //       SizedBox(height: 2),
                                            //       subheadingText(
                                            //         context,
                                            //         'ALL FARES ARE ENDORSED BY THE GPRTU.',
                                            //         TextAlign.start,
                                            //         10,
                                            //         3,
                                            //         Colors.blue,
                                            //       ),
                                            //     ],
                                            //   ),
                                            // ),
                                          ),
                                          // Divider(
                                          //   color: primaryContainerShade,
                                          // ),
                                          SizedBox(height: 10),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 17.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                // Row(
                                                //   children: [
                                                //     Icon(
                                                //       MingCute.bus_line,
                                                //       color: secondaryColor4,
                                                //       size: 17,
                                                //     ),
                                                //     SizedBox(width: 3),
                                                //     subheadingText(
                                                //       context,
                                                //       'Type: ',
                                                //       align: TextAlign.start,
                                                //       size: 12,
                                                //       maxlines: 1,
                                                //       color: whiteColor,
                                                //     ),
                                                //     subheadingText(
                                                //       context,
                                                //       'Trotro',
                                                //       align: TextAlign.start,
                                                //       size: 12,
                                                //       maxlines: 2,
                                                //       color: Colors.green,
                                                //     ),
                                                //   ],
                                                // ),

                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(width: 3),
                                                    subheadingText(
                                                      context,
                                                      trip.route.longName ?? '',
                                                      align: TextAlign.start,
                                                      size: 12,
                                                      maxlines: 1,
                                                      color: secondaryColor4,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return Scaffold(
          backgroundColor: secondaryBg,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(120),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [
                    primaryColor.withOpacity(0.95),
                    primaryColorDeep,
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 5,
                    top: -180,
                    right: -50,
                    child: Icon(
                      Icons.phone_android_rounded,
                      size: 200,
                      color: Color.fromRGBO(255, 255, 255, 0.05),
                    ),
                  ),
                  Positioned(
                    bottom: -190,
                    top: 5,
                    left: -50,
                    child: Icon(
                      Icons.luggage_rounded,
                      size: 280,
                      color: whiteColor.withOpacity(0.05),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    top: 20,
                    right: 20,
                    left: 20,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          headingTextMedium(
                            context,
                            "Available Trips",
                            FontWeight.bold,
                            20,
                            whiteColor,
                          ),
                          SizedBox(height: 2),
                          subheadingText(
                            context,
                            'Fares for certain routes may change periodically due to changes from our database.!!',
                            size: 12,
                            color: secondaryColor4,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          extendBody: true,
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: 8,
                itemBuilder: (_, __) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 12,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  height: 12,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
