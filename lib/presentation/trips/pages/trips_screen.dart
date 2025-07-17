import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:trotrolive_mobile_new/helpers/animation/showup_animation.dart';
import 'package:trotrolive_mobile_new/presentation/trips/repository/model/trips_model.dart';
import '../../../helpers/text_widgets.dart';
import '../../../helpers/widgets/dialogbox_util.dart';
import '../../../utils/constants/color constants/colors.dart';
import '../bloc/trips_bloc.dart';

class TripsPage extends StatefulWidget {
  TripsPage({super.key});

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

    // Trigger initial trip fetch
    context.read<TripsBloc>().add(FetchTripEvent());
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
              });
        }
      },
      builder: (BuildContext context, state) {
        if (state is TripsFetchedState) {
          final trips = state.trips!;
          final hasMore = state.hasMore;
          return Scaffold(
            backgroundColor: primaryColor,
            appBar: AppBar(
              //shadowColor: primaryContainerShade,
              //elevation: 0.1,
              // surfaceTintColor: whiteColor,
              backgroundColor: primaryColor,
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: headingTextMedium(
                context,
                "Available Trips",
                FontWeight.w600,
                16,
                whiteColor,
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
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ShowUpAnimation(
                          delay: 200,
                          child: Container(
                            height: 107,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: primarySucessShade,
                              border: Border.all(
                                width: 1,
                                color: Colors.green,
                              ),
                              borderRadius: BorderRadius.circular(17),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  headingTextMedium(context, 'Disclaimer!!',
                                      FontWeight.w600, 14),
                                  SizedBox(height: 8),
                                  subheadingTextMedium(
                                    context,
                                    'Fares for certain routes may change periodically due to changes from our database.',
                                    12,
                                  ),
                                  SizedBox(height: 15),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 40,
                        color: barBg.withOpacity(0.5),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              headingTextMedium(
                                context,
                                'Trips Available',
                                FontWeight.w600,
                                15,
                              ),
                              Container(
                                height: 30,
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
                                      'Found ${trips?.length} Trips',
                                      FontWeight.w600,
                                      12,
                                      Colors.green,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      SizedBox(
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
                                      color: primaryColor,
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
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      headingTextMedium(
                                                        context,
                                                        trip?.startStation.name
                                                                .toString() ??
                                                            '',
                                                        FontWeight.w600,
                                                        14,
                                                      ),
                                                      subheadingText(
                                                        context,
                                                        trip?.startStation
                                                                    .isBusStop ==
                                                                true
                                                            ? 'Bus Stop'
                                                            : 'Not Bus Stop',
                                                        TextAlign.start,
                                                        10,
                                                      ),
                                                      SizedBox(height: 20),
                                                      headingTextMedium(
                                                        context,
                                                        trip?.destination.name
                                                                .toString() ??
                                                            '',
                                                        FontWeight.w600,
                                                        14,
                                                      ),
                                                      Row(
                                                        children: [
                                                          subheadingText(
                                                            context,
                                                            trip?.destination
                                                                        .isBusStop ==
                                                                    true
                                                                ? 'Bus Stop'
                                                                : 'Not Bus Stop',
                                                            TextAlign.start,
                                                            10,
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
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    MingCute.bus_line,
                                                    color: outlineGrey,
                                                    size: 17,
                                                  ),
                                                  SizedBox(width: 3),
                                                  subheadingText(
                                                    context,
                                                    'Transport Type: ',
                                                    TextAlign.start,
                                                    12,
                                                    1,
                                                    whiteColor,
                                                  ),
                                                  subheadingText(
                                                    context,
                                                    'Trotro',
                                                    TextAlign.start,
                                                    12,
                                                    2,
                                                    secondaryColor3,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    MingCute.location_2_line,
                                                    color: outlineGrey,
                                                    size: 17,
                                                  ),
                                                  SizedBox(width: 3),
                                                  subheadingText(
                                                    context,
                                                    trip?.route.source ?? '',
                                                    TextAlign.start,
                                                    11,
                                                    1,
                                                    secondaryColor3,
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
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return Scaffold(
          backgroundColor: secondaryBg,
          body: Center(
            child: SpinKitWave(
              color: primaryColor,
              size: 20,
            ),
          ),
        );
      },
    );
  }
}
