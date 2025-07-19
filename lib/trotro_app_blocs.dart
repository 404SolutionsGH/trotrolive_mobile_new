import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/location/bloc/location_bloc.dart';
import 'presentation/stations/bloc/stations_bloc.dart';
import 'presentation/trips/bloc/trips_bloc.dart';
import 'trotro_app.dart';

class TrotroAppBlocs extends StatelessWidget {
  const TrotroAppBlocs({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LocationBloc()..add(LoadLocationEvent()),
        ),
        BlocProvider(
          create: (context) => StationBloc(context.read<LocationBloc>())
            ..add(FetchStationEvent()),
        ),
        BlocProvider(
          create: (context) => TripsBloc()..add(FetchTripEvent()),
        ),
      ],
      child: TrotroApp(),
    );
  }
}
