abstract class MapEvent {}

class UpdateStationEvent extends MapEvent {
  final String? stationName;
  final bool? showPopup;

  UpdateStationEvent({this.stationName, this.showPopup});
}
