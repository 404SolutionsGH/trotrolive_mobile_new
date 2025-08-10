import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trotrolive_mobile_new/presentation/home/components/pop%20up/popup_state.dart';
import 'popup_event.dart';

class PopupBloc extends Bloc<PopupEvent, PopupState> {
  PopupBloc() : super(PopupInitialState()) {
    on<TogglePopupEvent>((event, emit) {
      emit(PopupInitialState(showPopup: event.showPopup));
    });
  }
}
