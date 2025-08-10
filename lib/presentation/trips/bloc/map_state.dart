class MapState {
  final String? startPoint;
  final bool showPopup;

  MapState({this.startPoint, this.showPopup = false});

  MapState copyWith({String? startPoint, bool? showPopup}) {
    return MapState(
      startPoint: startPoint ?? this.startPoint,
      showPopup: showPopup ?? this.showPopup,
    );
  }
}
