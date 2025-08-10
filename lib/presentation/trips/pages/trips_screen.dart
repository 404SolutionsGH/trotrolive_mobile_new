import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trotrolive_mobile_new/helpers/widgets/cedi_widget.dart';
import '../../../helpers/text_widgets.dart';
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
  late ScrollController _scrollController;

  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);

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
              child: CustomScrollView(
                controller: _scrollController,
                physics: BouncingScrollPhysics(),
                slivers: [
                  const SliverToBoxAdapter(child: SizedBox(height: 15)),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        // if (trips.length <= 0) {
                        //   return Padding(
                        //     padding: EdgeInsets.all(30.0),
                        //     child: SizedBox(
                        //       height: MediaQuery.of(context).size.height * 0.5,
                        //       child: Column(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         crossAxisAlignment: CrossAxisAlignment.center,
                        //         children: [
                        //           headingTextMedium(
                        //             context,
                        //             'No trips found',
                        //             FontWeight.w500,
                        //             17,
                        //           ),
                        //           SizedBox(height: 13),
                        //           subheadingText(
                        //             context,
                        //             'There are no trips available for',
                        //             size: 14,
                        //             maxlines: 3,
                        //             color: subtitleColor,
                        //           ),
                        //           Row(
                        //             mainAxisAlignment: MainAxisAlignment.center,
                        //             children: [
                        //               subheadingText(
                        //                 context,
                        //                 ' ${widget.startLocation}  → ',
                        //                 size: 14,
                        //                 color: Colors.red,
                        //               ),
                        //               subheadingText(
                        //                 context,
                        //                 ' ${widget.destination}',
                        //                 size: 14,
                        //                 color: Colors.red,
                        //               ),
                        //             ],
                        //           ),
                        //           subheadingText(
                        //             context,
                        //             ' at the moment',
                        //             size: 14,
                        //             color: subtitleColor,
                        //           ),
                        //           SizedBox(height: 15),
                        //           GestureDetector(
                        //             onTap: () {},
                        //             child: Container(
                        //               height: 45,
                        //               width: MediaQuery.of(context).size.width,
                        //               decoration: BoxDecoration(
                        //                 border: Border.all(
                        //                   color: subtitleColor.withOpacity(0.5),
                        //                 ),
                        //                 borderRadius: BorderRadius.circular(50),
                        //                 boxShadow: [],
                        //               ),
                        //               child: Center(
                        //                 child: Row(
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.center,
                        //                   children: [
                        //                     Text(
                        //                       'Refresh',
                        //                       style: Theme.of(context)
                        //                           .textTheme
                        //                           .bodyMedium!
                        //                           .copyWith(
                        //                             color: blackColor,
                        //                             fontWeight: FontWeight.w500,
                        //                             fontSize: 15,
                        //                           ),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   );
                        // }
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
                                  margin: const EdgeInsets.only(bottom: 10),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    border: Border.all(
                                        color: primaryContainerShade,
                                        width: 2.5),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: [
                                              _dotIcon(25, 25,
                                                  'assets/pngs/bus_stop_48px.png'),
                                              const SizedBox(height: 5),
                                              ...List.generate(
                                                5,
                                                (_) => const Icon(Icons.circle,
                                                    size: 6,
                                                    color: outlineGrey),
                                              ),
                                              const SizedBox(height: 5),
                                              _dotIcon(25, 25,
                                                  'assets/pngs/location_48px.png'),
                                            ],
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                headingTextMedium(
                                                    context,
                                                    trip.startStation.name ??
                                                        'Loading..',
                                                    FontWeight.w600,
                                                    14),
                                                const SizedBox(height: 30),
                                                headingTextMedium(
                                                    context,
                                                    trip.destination.name ??
                                                        'Loading..',
                                                    FontWeight.w600,
                                                    14),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          SizedBox(
                                            width: 100,
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 100,
                                                  width: 1.2,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        primaryContainerShade,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const SizedBox(height: 8),
                                                    subheadingText(
                                                        context, 'FARE',
                                                        size: 11),
                                                    const SizedBox(height: 2),
                                                    Row(
                                                      children: [
                                                        CediSign(
                                                          size: 21,
                                                          weight:
                                                              FontWeight.bold,
                                                          color: Colors.blue,
                                                        ),
                                                        SizedBox(width: 1),
                                                        headingTextMedium(
                                                          context,
                                                          '10.50',
                                                          FontWeight.w600,
                                                          25,
                                                          Colors.blue,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
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

  Widget _dotIcon(double height, double width, String icon) {
    return Image.asset(
      height: height,
      width: width,
      icon,
    );
  }
}
