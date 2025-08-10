abstract class PopupState {}

class PopupInitialState extends PopupState {
  final bool showPopup;
  PopupInitialState({this.showPopup = false});
}
