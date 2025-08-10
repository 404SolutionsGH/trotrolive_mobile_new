import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trotrolive_mobile_new/presentation/stories/bloc/stories_bloc.dart';
import 'presentation/authentication screens/bloc/auth_bloc.dart';
import 'presentation/home/components/pop up/popup_bloc.dart';
import 'presentation/location/bloc/location_bloc.dart';
import 'presentation/stations/bloc/stations_bloc.dart';
import 'presentation/trips/bloc/trips_bloc.dart';
import 'trotro_app.dart';

class TrotroAppBlocs extends StatelessWidget {
  const TrotroAppBlocs({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => AuthBloc()..add(AppStartedEvent()),
      ),
      BlocProvider(
        create: (context) => LocationBloc()..add(LoadLocationEvent()),
      ),
      BlocProvider(
        create: (context) =>
            StationBloc(context.read<LocationBloc>())..add(FetchStationEvent()),
      ),
      BlocProvider(
        create: (context) => TripsBloc()..add(FetchTripEvent()),
      ),
      BlocProvider(
        create: (context) => StoriesBloc()..add(FetchStoriesEvent()),
      ),
      BlocProvider(
        create: (context) => PopupBloc(),
      )
    ], child: TrotroApp());
  }
}
