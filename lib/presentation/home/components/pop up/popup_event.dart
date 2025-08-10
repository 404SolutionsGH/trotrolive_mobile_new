abstract class PopupEvent {}

class TogglePopupEvent extends PopupEvent {
  final bool showPopup;
  TogglePopupEvent(this.showPopup);
}
