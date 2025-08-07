import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:marquee/marquee.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trotrolive_mobile_new/helpers/widgets/cedi_widget.dart';
import 'package:trotrolive_mobile_new/helpers/widgets/custom_button.dart';
import '../../../helpers/text_widgets.dart';
import '../../../utils/constants/color constants/colors.dart';
import '../bloc/trips_bloc.dart';

/*
class TripsPage extends StatefulWidget {
  final String? startLocation;
  final String? destination;

  const TripsPage({super.key, this.startLocation, this.destination});

  @override
  State<TripsPage> createState() => _TripsPageState();
}

class _TripsPageState extends State<TripsPage>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  bool _isLoadingMore = false;
  bool _hasMoreItems = true; // Added to track if more items exist
  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    _fetchInitialTrips();
  }

  void _fetchInitialTrips() {
    context.read<TripsBloc>().add(FetchTripEvent(
          startingPoint: widget.startLocation,
          destination: widget.destination,
        ));
  }

  void _onScroll() {
    // Update scroll offset
    setState(() {
      _scrollOffset = _scrollController.offset;
    });

    // Return if already loading or no more items
    if (_isLoadingMore || !_hasMoreItems) return;

    // Load more when 80% of the list is scrolled
    final thresholdReached = _scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8;

    if (thresholdReached) {
      final state = context.read<TripsBloc>().state;
      if (state is TripsFetchedState && state.nextUrl != null) {
        _isLoadingMore = true;
        context.read<TripsBloc>().add(
              LoadMoreTripsEvent(
                nextUrl: state.nextUrl!,
                currentTrips: state.trips ?? [],
              ),
            );
      } else {
        _hasMoreItems = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TripsBloc, TripsState>(
      listener: (context, state) {
        if (state is TripsFailureState) {
          _isLoadingMore = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        } else if (state is TripsFetchedState) {
          _isLoadingMore = false;
          // Update hasMoreItems based on whether nextUrl exists
          _hasMoreItems = state.nextUrl != null;
        }
      },
      builder: (context, state) {
        if (state is TripsLoading) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }

        if (state is TripsFetchedState) {
          final trips = state.trips ?? [];
          return Scaffold(
            backgroundColor: secondaryBg,
            body: CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                // Your SliverAppBar...
                if (trips.isEmpty)
                  const SliverToBoxAdapter(
                    child: Center(child: Text("No trips found")),
                  )
                else
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index >= trips.length) {
                          return _isLoadingMore
                              ? const Center(child: CircularProgressIndicator())
                              : const SizedBox.shrink();
                        }
                        final trip = trips[index];

                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Container(
                                height: 190,
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
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(17),
                                ),
                                child: Stack(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 145,
                                          child: Container(
                                            height: 130,
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
                                                            color: Colors.blue,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25),
                                                          ),
                                                          child: Center(
                                                            child: Icon(
                                                              MingCute
                                                                  .location_fill,
                                                              color: whiteColor,
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
                                                              color: whiteColor,
                                                              size: 15,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        headingTextMedium(
                                                          context,
                                                          trip.startStation
                                                                  .name ??
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
                                                          trip.destination
                                                                  .name ??
                                                              '',
                                                          FontWeight.w600,
                                                          14,
                                                        ),
                                                        subheadingText(
                                                          context,
                                                          trip.destination
                                                                      .isBusStop ==
                                                                  true
                                                              ? 'Bus Stop'
                                                              : 'Not Bus Stop',
                                                          align:
                                                              TextAlign.start,
                                                          size: 10,
                                                        ),
                                                      ],
                                                    ),
                                                  )
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
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 20,
                                                    width: 280,
                                                    child: Marquee(
                                                      blankSpace: 20.0,
                                                      velocity: 100.0,
                                                      pauseAfterRound:
                                                          Duration(seconds: 1),
                                                      startPadding: 10.0,
                                                      accelerationDuration:
                                                          Duration(seconds: 1),
                                                      accelerationCurve:
                                                          Curves.linear,
                                                      decelerationDuration:
                                                          Duration(
                                                              milliseconds:
                                                                  500),
                                                      decelerationCurve:
                                                          Curves.easeOut,
                                                      text:
                                                          trip.route.longName ??
                                                              '',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall!
                                                          .copyWith(
                                                            color: whiteColor,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                    ),
                                                  ),
                                                  // subheadingText(
                                                  //   context,
                                                  //   trip.route.longName ?? '',
                                                  //   align: TextAlign.start,
                                                  //   size: 12,
                                                  //   maxlines: 1,
                                                  //   color: secondaryColor4,
                                                  // ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      bottom: -5,
                                      top: 100,
                                      right: 15,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          CediSign(
                                            size: 25,
                                            weight: FontWeight.bold,
                                            color: Colors.green,
                                          ),
                                          headingTextMedium(
                                            context,
                                            '10.00p',
                                            FontWeight.bold,
                                            27,
                                            Colors.green,
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
                      childCount: trips.length + (_hasMoreItems ? 1 : 0),
                    ),
                  ),
              ],
            ),
          );
        }

        return const Scaffold(
          body: Center(
            child: Text("Something went wrong"),
          ),
        );
      },
    );
  }

  Widget _buildAppBar(int tripCount) {
    return Container(
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
            child: Icon(Icons.phone_android_rounded,
                size: 200, color: Colors.white.withOpacity(0.05)),
          ),
          Positioned(
            bottom: -190,
            top: 5,
            left: -50,
            child: Icon(Icons.luggage_rounded,
                size: 280, color: Colors.white.withOpacity(0.05)),
          ),
          Positioned(
            bottom: 20,
            top: 20,
            right: 20,
            left: 20,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 25),
                  headingTextMedium(context, "Available Trips", FontWeight.bold,
                      20, whiteColor),
                  const SizedBox(height: 2),
                  subheadingText(
                    context,
                    'Fares for certain routes may change periodically due to changes from our database.!!',
                    size: 12,
                    color: secondaryColor4,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 35,
                    width: 130,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: headingTextMedium(
                        context,
                        '$tripCount trip${tripCount == 1 ? '' : 's'} found!',
                        FontWeight.w600,
                        12,
                        whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/

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
  late ScrollController _scrollController;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()..addListener(_onScroll);
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_fadeController);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TripsBloc>().add(FetchTripEvent(
            startingPoint: widget.startLocation,
            destination: widget.destination,
          ));
    });
  }

  void _onScroll() {
    final bloc = context.read<TripsBloc>();
    final state = bloc.state;

    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 150 &&
        state is TripsFetchedState &&
        state.nextUrl != null &&
        !_isLoadingMore) {
      _isLoadingMore = true;

      bloc.add(LoadMoreTripsEvent(
        nextUrl: state.nextUrl!,
        currentTrips: state.trips ?? [],
      ));
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
        if (state is TripsFetchedState) {
          _isLoadingMore = false;
        }
        if (state is TripsFailureState) {
          _isLoadingMore = false;
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
            backgroundColor: secondaryBg,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(165),
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
                            SizedBox(height: 25),
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
                            SizedBox(height: 20),
                            Container(
                              height: 35,
                              width: 130,
                              decoration: BoxDecoration(
                                // color: secondaryColor3.withOpacity(0.4),
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  headingTextMedium(
                                    context,
                                    '${trips.length} trip found!',
                                    FontWeight.w600,
                                    12,
                                    whiteColor,
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
            extendBody: true,
            body: SafeArea(
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<TripsBloc>()..add(FetchTripEvent());
                },
                child: CustomScrollView(
                  controller: _scrollController,
                  physics: BouncingScrollPhysics(),
                  slivers: [
                    const SliverToBoxAdapter(child: SizedBox(height: 15)),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          if (trips.length == 0) {
                            return Padding(
                              padding: EdgeInsets.all(30.0),
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    headingTextMedium(
                                      context,
                                      'No trips found',
                                      FontWeight.w500,
                                      17,
                                    ),
                                    SizedBox(height: 13),
                                    subheadingText(
                                      context,
                                      'There are no trips available for',
                                      size: 14,
                                      maxlines: 3,
                                      color: subtitleColor,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        subheadingText(
                                          context,
                                          ' ${widget.startLocation}  → ',
                                          size: 14,
                                          color: Colors.red,
                                        ),
                                        subheadingText(
                                          context,
                                          ' ${widget.destination}',
                                          size: 14,
                                          color: Colors.red,
                                        ),
                                      ],
                                    ),
                                    subheadingText(
                                      context,
                                      ' at the moment',
                                      size: 14,
                                      color: subtitleColor,
                                    ),
                                    SizedBox(height: 15),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        height: 45,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                                subtitleColor.withOpacity(0.5),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          boxShadow: [],
                                        ),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Refresh',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      color: blackColor,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          if (trips.isEmpty) {
                            return const SliverToBoxAdapter(
                              child: Center(child: Text("No trips found.")),
                            );
                          }
                          final trip = trips[index];
                          return Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/map',
                                      arguments: {
                                        'startLat':
                                            trip.startStation.stationLatitude,
                                        'startLong':
                                            trip.startStation.stationLongitude,
                                        'desLat':
                                            trip.destination.stationLatitude,
                                        'desLong':
                                            trip.destination.stationLongitude,
                                        'start': trip.startStation.name,
                                        'dest': trip.destination.name,
                                        'fare': trip.fare,
                                      },
                                    );
                                  },
                                  child: Container(
                                    height: 190,
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
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(17),
                                    ),
                                    child: Stack(
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 145,
                                              child: Container(
                                                height: 130,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(14),
                                                    topRight:
                                                        Radius.circular(14),
                                                  ),
                                                  color: whiteColor,
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 5.0,
                                                      vertical: 15),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
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
                                                              color:
                                                                  outlineGrey,
                                                              size: 6,
                                                            ),
                                                            SizedBox(height: 3),
                                                            Icon(
                                                              Icons.circle,
                                                              color:
                                                                  outlineGrey,
                                                              size: 6,
                                                            ),
                                                            SizedBox(height: 3),
                                                            Icon(
                                                              Icons.circle,
                                                              color:
                                                                  outlineGrey,
                                                              size: 6,
                                                            ),
                                                            Icon(
                                                              Icons.circle,
                                                              color:
                                                                  outlineGrey,
                                                              size: 6,
                                                            ),
                                                            SizedBox(height: 3),
                                                            Container(
                                                              height: 22,
                                                              width: 22,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    Colors.red,
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
                                                      Flexible(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            headingTextMedium(
                                                              context,
                                                              trip.startStation
                                                                      .name ??
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
                                                              align: TextAlign
                                                                  .start,
                                                              size: 10,
                                                            ),
                                                            SizedBox(
                                                                height: 20),
                                                            headingTextMedium(
                                                              context,
                                                              trip.destination
                                                                      .name ??
                                                                  '',
                                                              FontWeight.w600,
                                                              14,
                                                            ),
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
                                                      )
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
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        height: 20,
                                                        width: 280,
                                                        child: Marquee(
                                                          blankSpace: 20.0,
                                                          velocity: 100.0,
                                                          pauseAfterRound:
                                                              Duration(
                                                                  seconds: 1),
                                                          startPadding: 10.0,
                                                          accelerationDuration:
                                                              Duration(
                                                                  seconds: 1),
                                                          accelerationCurve:
                                                              Curves.linear,
                                                          decelerationDuration:
                                                              Duration(
                                                                  milliseconds:
                                                                      500),
                                                          decelerationCurve:
                                                              Curves.easeOut,
                                                          text: trip.route
                                                                  .longName ??
                                                              '',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall!
                                                                  .copyWith(
                                                                    color:
                                                                        whiteColor,
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                  ),
                                                        ),
                                                      ),
                                                      // subheadingText(
                                                      //   context,
                                                      //   trip.route.longName ?? '',
                                                      //   align: TextAlign.start,
                                                      //   size: 12,
                                                      //   maxlines: 1,
                                                      //   color: secondaryColor4,
                                                      // ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Positioned(
                                          bottom: -5,
                                          top: 100,
                                          right: 15,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              CediSign(
                                                size: 25,
                                                weight: FontWeight.bold,
                                                color: Colors.green,
                                              ),
                                              headingTextMedium(
                                                context,
                                                '10.00p',
                                                FontWeight.bold,
                                                27,
                                                Colors.green,
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
                          );
                        },
                        childCount: trips.length + (hasMore ? 1 : 0),
                      ),
                    ),
                  ],
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
