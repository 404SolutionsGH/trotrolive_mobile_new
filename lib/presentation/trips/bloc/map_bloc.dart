import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trotrolive_mobile_new/presentation/trips/bloc/map_event.dart';

import 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState()) {
    on<UpdateStationEvent>((event, emit) {
      emit(state.copyWith(
        startPoint: event.stationName,
        showPopup: event.showPopup,
      ));
    });
  }
}
