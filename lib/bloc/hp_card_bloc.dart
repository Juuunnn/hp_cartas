import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'hp_card_event.dart';
part 'hp_card_state.dart';

class HpCardBloc extends Bloc<HpCardEvent, HpCardState> {
  HpCardBloc() : super(HpCardInitial()) {
    on<HpCardEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
